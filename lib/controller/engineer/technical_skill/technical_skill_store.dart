import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/engineer/technical_skill/technical_skill_controller.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/engineer/master_data_response.dart';
import 'package:ticky/model/engineer/technical_skill/technical_skills_response.dart';

part 'technical_skill_store.g.dart';

class TechnicalSkillStore = TechnicalSkillStoreBase with _$TechnicalSkillStore;

abstract class TechnicalSkillStoreBase with Store {
  @observable
  TechnicalSkillResponse? cachedTechnicalSkillResponse;

  @observable
  MasterData? skillName;

  @observable
  MasterData? experienceLevel;

  @observable
  MasterDataResponse? skillNameInitialData;

  @observable
  MasterDataResponse? experienceLevelInitialData;

  @action
  void setSkillName(MasterData? value) {
    skillName = value;
  }

  @action
  void setExperienceLevel(MasterData? value) {
    experienceLevel = value;
  }

  @observable
  GlobalKey<FormState> technicalSkillFormState = GlobalKey();

  @action
  Future<void> onSubmit() async {
    if (technicalSkillFormState.currentState!.validate()) {
      technicalSkillFormState.currentState!.save();

      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addTechnicalSkillApiState, value: true);

      Map<String, dynamic> request = {
        "id": "",
        "user_id": userStore.userId,
        "name": skillName!.value.validate(),
        "level": experienceLevel!.value.validate(),
      };

      await TechnicalSkillController.addTechnicalSkillApi(request: request).then((res) {
        appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addTechnicalSkillApiState, value: false);
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
    if (technicalSkillFormState.currentState!.validate()) {
      technicalSkillFormState.currentState!.save();

      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addTechnicalSkillApiState, value: true);

      Map<String, dynamic> request = {
        "id": id,
        "user_id": userStore.userId,
        "name": skillName!.value.validate(),
        "level": experienceLevel!.value.validate(),
      };

      log(request);

      await TechnicalSkillController.addTechnicalSkillApi(request: request).then((res) {
        appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addTechnicalSkillApiState, value: false);

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
  Future<void> deleteTechnicalSkill({required int id}) async {
    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addTechnicalSkillApiState, value: true);

    await TechnicalSkillController.deleteTechnicalSkillApi(id: id).then((res) {
      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addTechnicalSkillApiState, value: false);

      toast(res.message.validate());

      // finish(getContext);
    }).catchError((e) {
      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.loginApiState, value: false);
      toast(e.toString(), print: true);
    });

    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.loginApiState, value: false);
  }

  void dispose() {
    skillName = null;

    experienceLevel = null;
  }
}
