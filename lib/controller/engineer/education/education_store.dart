import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/engineer/education/education_controller.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/engineer/education/education_response.dart';
import 'package:ticky/utils/config.dart';

part 'education_store.g.dart';

class EducationStore = EducationStoreBase with _$EducationStore;

abstract class EducationStoreBase with Store {
  @observable
  EducationResponse? cachedEducationResponse;

  @observable
  TextEditingController nameOfDegreeCont = TextEditingController();

  @observable
  TextEditingController universityNameCont = TextEditingController();

  @observable
  TextEditingController issueDateCont = TextEditingController();
  @observable
  DateTime? issueDate;

  @observable
  TextEditingController expireDateCont = TextEditingController();

  @observable
  DateTime? expireDate;

  @observable
  TextEditingController fileUploadCont = TextEditingController();

  @observable
  List<File> educationFiles = ObservableList();

  @action
  Future<void> setEducationFiles({required List<File> file}) async {
    educationFiles = file;
  }

  @observable
  GlobalKey<FormState> educationFormState = GlobalKey();

  @observable
  FocusNode nameOfDegreeFocusNode = FocusNode();

  @observable
  FocusNode universityNameFocusNode = FocusNode();

  @action
  Future<void> onSubmit() async {
    if (educationFormState.currentState!.validate()) {
      educationFormState.currentState!.save();

      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addEducationApiState, value: true);

      Map<String, dynamic> request = {
        "id": "",
        "user_id": userStore.userId.validate(),
        "degree_name": nameOfDegreeCont.text.trim().validate(),
        "university_name": universityNameCont.text.trim().validate(),
        "issue_date": DateFormat(ShowDateFormat.yyyyMmDdDash).format(issueDate!),
        "status": 1,
      };

      log(request);

      await EducationController.addEducationApiMultipart(request: request, files: educationFiles).then((res) {
        appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addEducationApiState, value: false);

        toast(res.message.validate());
        // finish(getContext);
      }).catchError((e) {
        appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addEducationApiState, value: false);
        toast(e.toString(), print: true);
      });

      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addEducationApiState, value: false);
    }
  }

  @action
  Future<void> onUpdate({required int id}) async {
    if (educationFormState.currentState!.validate()) {
      educationFormState.currentState!.save();

      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addEducationApiState, value: true);

      Map<String, dynamic> request = {
        "id": id,
        "user_id": userStore.userId,
        "degree_name": nameOfDegreeCont.text.trim().validate(),
        "university_name": universityNameCont.text.trim().validate(),
        "issue_date": DateFormat(ShowDateFormat.yyyyMmDdDash).format(issueDate!),
        "status": 1,
      };

      log(request);

      await EducationController.addEducationApiMultipart(request: request, files: educationFiles).then((res) {
        appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addEducationApiState, value: false);

        toast(res.message.validate());

        // finish(getContext);
      }).catchError((e) {
        appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addEducationApiState, value: false);
        toast(e.toString(), print: true);
      });

      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addEducationApiState, value: false);
    }
  }

  @action
  Future<void> deleteEducation({required int id}) async {
    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addEducationApiState, value: true);

    await EducationController.deleteEducationApi(id: id).then((res) {
      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addEducationApiState, value: false);

      toast(res.message.validate());
    }).catchError((e) {
      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addEducationApiState, value: false);
      toast(e.toString(), print: true);
    });

    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addEducationApiState, value: false);
  }

  void dispose() {
    nameOfDegreeCont.clear();
    universityNameCont.clear();
    issueDateCont.clear();
    issueDate = null;
    expireDateCont.clear();
    expireDate = null;
    fileUploadCont.clear();
    educationFiles.clear();
  }
}
