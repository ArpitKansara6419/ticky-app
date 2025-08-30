import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/engineer/spoken_languages/spoken_language_controller.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/engineer/master_data_response.dart';
import 'package:ticky/model/engineer/spoken_languages/spoken_language_response.dart';

part 'spoken_language_store.g.dart';

class SpokenLanguageStore = SpokenLanguageStoreBase with _$SpokenLanguageStore;

abstract class SpokenLanguageStoreBase with Store {
  @observable
  SpokenLanguageResponse? cachedSpokenLanguageResponse;

  @observable
  MasterData? spokenLanguages;

  @observable
  MasterData? spokenLanguageLevel;

  @observable
  ObservableList<MasterData>? selectedSpokenLanguageProficiency = ObservableList();

  @observable
  MasterDataResponse? spokenLanguageInitialData;

  @observable
  MasterDataResponse? spokenLanguageLevelInitialData;

  @observable
  MasterDataResponse? spokenLanguageProficiencyInitialData;

  @action
  void setSpokenLanguages(MasterData? value) {
    spokenLanguages = value;
  }

  @action
  void setSpokenLanguageLevel(MasterData? value) {
    spokenLanguageLevel = value;
  }

  @observable
  GlobalKey<FormState> spokenLanguageFormState = GlobalKey();

  @action
  void setSelectedSpokenLanguageProficiency(MasterData value) {
    if (selectedSpokenLanguageProficiency!.any((e) => e.value.validate() == value.value.validate())) {
      selectedSpokenLanguageProficiency?.removeWhere((e) => e.value.validate() == value.value.validate());
    } else {
      selectedSpokenLanguageProficiency?.add(value);
    }
  }

  @action
  Future<void> onSubmit() async {
    if (spokenLanguageFormState.currentState!.validate()) {
      spokenLanguageFormState.currentState!.save();

      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addSpokenLanguageApiState, value: true);

      Map<String, dynamic> request = {
        "id": "",
        "user_id": userStore.userId,
        "language_name": spokenLanguages?.value.validate(),
        "proficiency_level": spokenLanguageLevel?.value.validate(),
        "read": selectedSpokenLanguageProficiency?.any((e) => e.value == "read").getIntBool(),
        "write": selectedSpokenLanguageProficiency?.any((e) => e.value == "write").getIntBool(),
        "speak": selectedSpokenLanguageProficiency?.any((e) => e.value == "speak").getIntBool(),
      };

      log(request);

      await SpokenLanguageController.addSpokenLanguageApi(request: request).then((res) {
        appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addSpokenLanguageApiState, value: false);
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
    if (spokenLanguageFormState.currentState!.validate()) {
      spokenLanguageFormState.currentState!.save();

      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addSpokenLanguageApiState, value: true);

      Map<String, dynamic> request = {
        "id": id,
        "user_id": userStore.userId,
        "language_name": spokenLanguages?.value.validate(),
        "proficiency_level": spokenLanguageLevel?.value.validate(),
        "read": selectedSpokenLanguageProficiency?.any((e) => e.value == "read").getIntBool(),
        "write": selectedSpokenLanguageProficiency?.any((e) => e.value == "write").getIntBool(),
        "speak": selectedSpokenLanguageProficiency?.any((e) => e.value == "speak").getIntBool(),
      };

      log(request);

      await SpokenLanguageController.addSpokenLanguageApi(request: request).then((res) {
        appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addSpokenLanguageApiState, value: false);

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
  Future<void> deleteSpokenLanguage({required int id}) async {
    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addSpokenLanguageApiState, value: true);

    await SpokenLanguageController.deleteSpokenLanguageApi(id: id).then((res) {
      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addSpokenLanguageApiState, value: false);

      toast(res.message.validate());

      // finish(getContext);
    }).catchError((e) {
      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.loginApiState, value: false);
      toast(e.toString(), print: true);
    });

    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.loginApiState, value: false);
  }

  void dispose() {
    spokenLanguages = null;
    spokenLanguageLevel = null;
    selectedSpokenLanguageProficiency = ObservableList();
  }
}
