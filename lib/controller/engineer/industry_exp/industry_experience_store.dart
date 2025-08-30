import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/engineer/industry_exp/industry_experience_controller.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/engineer/industry_exp/industry_experience_response.dart';
import 'package:ticky/model/engineer/master_data_response.dart';

part 'industry_experience_store.g.dart';

class IndustryExperienceStore = IndustryExperienceStoreBase with _$IndustryExperienceStore;

abstract class IndustryExperienceStoreBase with Store {
  @observable
  IndustryExperienceResponse? cachedIndustryExperienceResponse;

  @observable
  MasterDataResponse? industryNameInitialData;

  @observable
  MasterDataResponse? industryLevelInitialData;

  @observable
  MasterData? industryName;

  @observable
  MasterData? industryLevel;

  @action
  void setIndustryName(MasterData? value) {
    industryName = value;
  }

  @action
  void setIndustryLevel(MasterData? value) {
    industryLevel = value;
  }

  @observable
  GlobalKey<FormState> industryExperienceFormState = GlobalKey();

  @action
  Future<void> onSubmit() async {
    if (industryExperienceFormState.currentState!.validate()) {
      industryExperienceFormState.currentState!.save();

      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addIndustryExperienceApiState, value: true);

      Map<String, dynamic> request = {
        "id": "",
        "user_id": userStore.userId,
        "name": industryName?.value.validate(),
        "experience": industryLevel?.value.validate(),
      };

      log(request);

      await IndustryExperienceController.addIndustryExperienceApi(request: request).then((res) {
        appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addIndustryExperienceApiState, value: false);
        toast(res.message.validate());

        finish(getContext);
      }).catchError((e) {
        appLoaderStore.setLoaderValue(appState: AppLoaderStateName.loginApiState, value: false);
        toast(e.toString(), print: true);
      });

      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.loginApiState, value: false);
    }
  }

  @action
  Future<void> onUpdate({required int id}) async {
    if (industryExperienceFormState.currentState!.validate()) {
      industryExperienceFormState.currentState!.save();

      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addIndustryExperienceApiState, value: true);

      Map<String, dynamic> request = {
        "id": id,
        "user_id": userStore.userId,
        "name": industryName?.value.validate(),
        "experience": industryLevel?.value.validate(),
      };

      log(request);

      await IndustryExperienceController.addIndustryExperienceApi(request: request).then((res) {
        appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addIndustryExperienceApiState, value: false);

        toast(res.message.validate());

        finish(getContext);
      }).catchError((e) {
        appLoaderStore.setLoaderValue(appState: AppLoaderStateName.loginApiState, value: false);
        toast(e.toString(), print: true);
      });

      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.loginApiState, value: false);
    }
  }

  @action
  Future<void> deleteIndustryExperience({required int id}) async {
    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addIndustryExperienceApiState, value: true);

    await IndustryExperienceController.deleteIndustryExperienceApi(id: id).then((res) {
      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addIndustryExperienceApiState, value: false);

      toast(res.message.validate());

      // finish(getContext);
    }).catchError((e) {
      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.loginApiState, value: false);
      toast(e.toString(), print: true);
    });

    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.loginApiState, value: false);
  }

  void dispose() {
    industryName = null;
    industryLevel = null;
  }
}
