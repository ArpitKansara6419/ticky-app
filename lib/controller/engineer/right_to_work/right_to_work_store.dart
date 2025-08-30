import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/engineer/right_to_work/right_controller.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/engineer/master_data_response.dart';
import 'package:ticky/network/api_client.dart';
import 'package:ticky/utils/imports.dart';

part 'right_to_work_store.g.dart';

class RightToWorkStore = RightToWorkStoreBase with _$RightToWorkStore;

abstract class RightToWorkStoreBase with Store {
  @observable
  GlobalKey<FormState> rightToWorkState = GlobalKey();

  @observable
  MasterDataResponse? rightToWorkInitialData;

  @observable
  MasterData? rightToWorkSelectedData;

  @observable
  bool isDataAlreadyAvailable = false;

  @action
  Future<void> setRightToWorkSelectedData(MasterData? value) async {
    rightToWorkSelectedData = value;
  }

  void init() async {
    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.rightToWorkApiState, value: true);

    await RightController.getRightToWorkListApi().then((value) {
      var data = value.rightToWorkData!;

      if (data.type != null) {
        rightToWorkSelectedData = MasterData(value: data.type, label: data.type.capitalizeFirstLetter());
        isDataAlreadyAvailable = true;
      }

      if (data.issueDate != null) {
        issueDate = DateTime.parse(data.issueDate.validate());

        issueDateCont.text = DateFormat(ShowDateFormat.ddMmmYyyy).format(issueDate!).toString();
      }

      if (data.expireDate != null) {
        expireDate = DateTime.parse(data.expireDate.validate());
        expireDateCont.text = DateFormat(ShowDateFormat.ddMmmYyyy).format(expireDate!).toString();
      }

      if (data.universityCertificateFile.validate().isNotEmpty) {
        setUniversityCertificateFiles([File(data.universityCertificateFile.validate())]);
        universityCertificateCont.text = "1" + " File Selected";
      }

      if (data.visaCopyFile.validate().isNotEmpty) {
        setVisaFiles([File(data.visaCopyFile.validate())]);
        visaCont.text = "1" + " File Selected";
      }

      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.rightToWorkApiState, value: false);
    }).catchError((e) {
      toast(e.toString());
      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.rightToWorkApiState, value: false);
    });
  }

  //region University Certificate
  @observable
  TextEditingController universityCertificateCont = TextEditingController();

  @observable
  List<File> universityCertificateFile = [];

  @action
  Future<void> setUniversityCertificateFiles(List<File> value) async {
    universityCertificateFile = value;
  }

  //endregion

  //region University Certificate
  @observable
  TextEditingController visaCont = TextEditingController();

  @observable
  List<File> visaFile = [];

  @action
  Future<void> setVisaFiles(List<File> value) async {
    visaFile = value;
  }

  //endregion

  @observable
  TextEditingController otherDocumentCont = TextEditingController();

  @observable
  TextEditingController issueDateCont = TextEditingController();

  @observable
  DateTime? issueDate;

  @observable
  TextEditingController expireDateCont = TextEditingController();

  @observable
  DateTime? expireDate;

  @action
  Future<void> onSubmit() async {
    if (rightToWorkState.currentState!.validate()) {
      rightToWorkState.currentState!.save();

      MultipartRequest multiPartRequest = await getMultiPartRequest(RightToWorkEndPoints.saveRightToWorkUrl);

      Map<String, dynamic> req = {
        "user_id": userStore.userId.validate(),
        "type": rightToWorkSelectedData!.value.validate(),
        "other_name": otherDocumentCont.text.validate().trim(),
        "status": "1",
        "document_type": null,
      };
      if (issueDate != null) {
        req.putIfAbsent(
          "issue_date",
          () => DateFormat(ShowDateFormat.yyyyMmDdDash).format(issueDate!),
        );
      }
      if (otherDocumentCont.text.validate().isNotEmpty) {
        req.putIfAbsent(
          "other_name",
          () => otherDocumentCont.text.validate().trim(),
        );
      }
      if (expireDate != null) {
        req.putIfAbsent(
          "expire_date",
          () => DateFormat(ShowDateFormat.yyyyMmDdDash).format(expireDate!),
        );
      }

      req.forEach((key, value) => multiPartRequest.fields[key] = value.toString());

      if (universityCertificateFile.validate().isNotEmpty && universityCertificateFile.validate().any((e) => !e.path.contains("right_to_work_documents"))) {
        await Future.forEach<File>(universityCertificateFile, (element) async {
          multiPartRequest.files.add(await MultipartFile.fromPath("university_certificate_file", element.path));
        });
      }

      if (visaFile.validate().isNotEmpty && visaFile.validate().any((e) => !e.path.contains("right_to_work_documents"))) {
        await Future.forEach<File>(visaFile, (element) async {
          multiPartRequest.files.add(await MultipartFile.fromPath("visa_copy_file", element.path));
        });
      }

      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.rightToWorkApiState, value: true);

      await RightController.addRightToWorkApiMultipart(multipartRequest: multiPartRequest);
    }
  }

  @action
  Future<void> dispose() async {
    rightToWorkSelectedData = null;
    universityCertificateCont.clear();
    universityCertificateFile = [];
    visaCont.clear();
    visaFile = [];
    otherDocumentCont.clear();
    issueDateCont.clear();
    issueDate = null;
    expireDateCont.clear();
    expireDate = null;
  }
}
