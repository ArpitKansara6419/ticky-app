import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/engineer/technical_certification/technical_certification_controller.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/engineer/master_data_response.dart';
import 'package:ticky/model/engineer/technical_certification/technical_certification_response.dart';
import 'package:ticky/utils/config.dart';

part 'technical_certification_store.g.dart';

class TechnicalCertificationStore = TechnicalCertificationStoreBase with _$TechnicalCertificationStore;

abstract class TechnicalCertificationStoreBase with Store {
  @observable
  TechnicalCertificationResponse? cachedTechnicalSkillResponse;

  @observable
  MasterData? certificateName;

  @observable
  MasterDataResponse? certificateInitialData;

  @observable
  TextEditingController certificateIdCont = TextEditingController();

  @observable
  DateTime? issueDate;

  @observable
  TextEditingController issueDateCont = TextEditingController();

  @observable
  DateTime? expireDate;

  @observable
  TextEditingController expireDateCont = TextEditingController();

  @action
  void setCertificateName(MasterData? value) {
    certificateName = value;
  }

  @observable
  TextEditingController fileUploadCont = TextEditingController();

  @observable
  List<File> recentlyUpdatedFiles = ObservableList();

  @action
  Future<void> setDocumentFiles({required List<File> file}) async {
    recentlyUpdatedFiles = file;
  }

  @observable
  GlobalKey<FormState> technicalCertificationFormState = GlobalKey();

  @action
  Future<void> onSubmit() async {
    if (technicalCertificationFormState.currentState!.validate()) {
      technicalCertificationFormState.currentState!.save();

      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addTechnicalCertificateApiState, value: true);

      Map<String, dynamic> request = {
        "id": "",
        "user_id": userStore.userId,
        "certification_type": certificateName!.value.validate(),
        "certification_id": certificateIdCont.text.trim().validate(),
        "issue_date": DateFormat(ShowDateFormat.yyyyMmDdDash).format(issueDate!),
        "expire_date": expireDate != null ? DateFormat(ShowDateFormat.yyyyMmDdDash).format(expireDate!) : null,
        "status": "1",
      };

      await TechnicalCertificationController.addTechnicalCertificationApi(request: request, files: recentlyUpdatedFiles).then((res) {
        appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addTechnicalCertificateApiState, value: false);
        toast(res.message.validate());
      }).catchError((e) {
        appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addTechnicalCertificateApiState, value: false);
        toast(e.toString(), print: true);
      });

      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addTechnicalCertificateApiState, value: false);
    }
  }

  @action
  Future<void> onUpdate({required int id}) async {
    if (technicalCertificationFormState.currentState!.validate()) {
      technicalCertificationFormState.currentState!.save();

      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addTechnicalCertificateApiState, value: true);

      Map<String, dynamic> request = {
        "id": id,
        "user_id": userStore.userId,
        "certification_type": certificateName!.value.validate(),
        "certification_id": certificateIdCont.text.trim().validate(),
        "issue_date": DateFormat(ShowDateFormat.yyyyMmDdDash).format(issueDate!),
        "expire_date": expireDate != null ? DateFormat(ShowDateFormat.yyyyMmDdDash).format(expireDate!) : null,
        "status": "1",
      };

      log(request);

      await TechnicalCertificationController.addTechnicalCertificationApi(request: request, files: recentlyUpdatedFiles).then((res) {
        appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addTechnicalCertificateApiState, value: false);

        toast(res.message.validate());
      }).catchError((e) {
        appLoaderStore.setLoaderValue(appState: AppLoaderStateName.loginApiState, value: false);
        toast(e.toString(), print: true);
      });

      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.loginApiState, value: false);
    }
  }

  @action
  Future<void> deleteTechnicalSkill({required int id}) async {
    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addTechnicalCertificateApiState, value: true);

    await TechnicalCertificationController.deleteTechnicalCertificationApi(id: id).then((res) {
      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addTechnicalCertificateApiState, value: false);

      toast(res.message.validate());
    }).catchError((e) {
      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.loginApiState, value: false);
      toast(e.toString(), print: true);
    });

    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.loginApiState, value: false);
  }

  void dispose() {
    certificateName = null;
    certificateInitialData = null;
    certificateIdCont.clear();
    issueDate = null;
    issueDateCont.clear();
    expireDate = null;
    expireDateCont.clear();
    fileUploadCont.clear();
    recentlyUpdatedFiles = ObservableList();
    technicalCertificationFormState = GlobalKey();
  }
}
