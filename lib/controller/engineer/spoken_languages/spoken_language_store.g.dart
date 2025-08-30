// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spoken_language_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SpokenLanguageStore on SpokenLanguageStoreBase, Store {
  late final _$cachedSpokenLanguageResponseAtom = Atom(
      name: 'SpokenLanguageStoreBase.cachedSpokenLanguageResponse',
      context: context);

  @override
  SpokenLanguageResponse? get cachedSpokenLanguageResponse {
    _$cachedSpokenLanguageResponseAtom.reportRead();
    return super.cachedSpokenLanguageResponse;
  }

  @override
  set cachedSpokenLanguageResponse(SpokenLanguageResponse? value) {
    _$cachedSpokenLanguageResponseAtom
        .reportWrite(value, super.cachedSpokenLanguageResponse, () {
      super.cachedSpokenLanguageResponse = value;
    });
  }

  late final _$spokenLanguagesAtom =
      Atom(name: 'SpokenLanguageStoreBase.spokenLanguages', context: context);

  @override
  MasterData? get spokenLanguages {
    _$spokenLanguagesAtom.reportRead();
    return super.spokenLanguages;
  }

  @override
  set spokenLanguages(MasterData? value) {
    _$spokenLanguagesAtom.reportWrite(value, super.spokenLanguages, () {
      super.spokenLanguages = value;
    });
  }

  late final _$spokenLanguageLevelAtom = Atom(
      name: 'SpokenLanguageStoreBase.spokenLanguageLevel', context: context);

  @override
  MasterData? get spokenLanguageLevel {
    _$spokenLanguageLevelAtom.reportRead();
    return super.spokenLanguageLevel;
  }

  @override
  set spokenLanguageLevel(MasterData? value) {
    _$spokenLanguageLevelAtom.reportWrite(value, super.spokenLanguageLevel, () {
      super.spokenLanguageLevel = value;
    });
  }

  late final _$selectedSpokenLanguageProficiencyAtom = Atom(
      name: 'SpokenLanguageStoreBase.selectedSpokenLanguageProficiency',
      context: context);

  @override
  ObservableList<MasterData>? get selectedSpokenLanguageProficiency {
    _$selectedSpokenLanguageProficiencyAtom.reportRead();
    return super.selectedSpokenLanguageProficiency;
  }

  @override
  set selectedSpokenLanguageProficiency(ObservableList<MasterData>? value) {
    _$selectedSpokenLanguageProficiencyAtom
        .reportWrite(value, super.selectedSpokenLanguageProficiency, () {
      super.selectedSpokenLanguageProficiency = value;
    });
  }

  late final _$spokenLanguageInitialDataAtom = Atom(
      name: 'SpokenLanguageStoreBase.spokenLanguageInitialData',
      context: context);

  @override
  MasterDataResponse? get spokenLanguageInitialData {
    _$spokenLanguageInitialDataAtom.reportRead();
    return super.spokenLanguageInitialData;
  }

  @override
  set spokenLanguageInitialData(MasterDataResponse? value) {
    _$spokenLanguageInitialDataAtom
        .reportWrite(value, super.spokenLanguageInitialData, () {
      super.spokenLanguageInitialData = value;
    });
  }

  late final _$spokenLanguageLevelInitialDataAtom = Atom(
      name: 'SpokenLanguageStoreBase.spokenLanguageLevelInitialData',
      context: context);

  @override
  MasterDataResponse? get spokenLanguageLevelInitialData {
    _$spokenLanguageLevelInitialDataAtom.reportRead();
    return super.spokenLanguageLevelInitialData;
  }

  @override
  set spokenLanguageLevelInitialData(MasterDataResponse? value) {
    _$spokenLanguageLevelInitialDataAtom
        .reportWrite(value, super.spokenLanguageLevelInitialData, () {
      super.spokenLanguageLevelInitialData = value;
    });
  }

  late final _$spokenLanguageProficiencyInitialDataAtom = Atom(
      name: 'SpokenLanguageStoreBase.spokenLanguageProficiencyInitialData',
      context: context);

  @override
  MasterDataResponse? get spokenLanguageProficiencyInitialData {
    _$spokenLanguageProficiencyInitialDataAtom.reportRead();
    return super.spokenLanguageProficiencyInitialData;
  }

  @override
  set spokenLanguageProficiencyInitialData(MasterDataResponse? value) {
    _$spokenLanguageProficiencyInitialDataAtom
        .reportWrite(value, super.spokenLanguageProficiencyInitialData, () {
      super.spokenLanguageProficiencyInitialData = value;
    });
  }

  late final _$spokenLanguageFormStateAtom = Atom(
      name: 'SpokenLanguageStoreBase.spokenLanguageFormState',
      context: context);

  @override
  GlobalKey<FormState> get spokenLanguageFormState {
    _$spokenLanguageFormStateAtom.reportRead();
    return super.spokenLanguageFormState;
  }

  @override
  set spokenLanguageFormState(GlobalKey<FormState> value) {
    _$spokenLanguageFormStateAtom
        .reportWrite(value, super.spokenLanguageFormState, () {
      super.spokenLanguageFormState = value;
    });
  }

  late final _$onSubmitAsyncAction =
      AsyncAction('SpokenLanguageStoreBase.onSubmit', context: context);

  @override
  Future<void> onSubmit() {
    return _$onSubmitAsyncAction.run(() => super.onSubmit());
  }

  late final _$onUpdateAsyncAction =
      AsyncAction('SpokenLanguageStoreBase.onUpdate', context: context);

  @override
  Future<void> onUpdate({required int id}) {
    return _$onUpdateAsyncAction.run(() => super.onUpdate(id: id));
  }

  late final _$deleteSpokenLanguageAsyncAction = AsyncAction(
      'SpokenLanguageStoreBase.deleteSpokenLanguage',
      context: context);

  @override
  Future<void> deleteSpokenLanguage({required int id}) {
    return _$deleteSpokenLanguageAsyncAction
        .run(() => super.deleteSpokenLanguage(id: id));
  }

  late final _$SpokenLanguageStoreBaseActionController =
      ActionController(name: 'SpokenLanguageStoreBase', context: context);

  @override
  void setSpokenLanguages(MasterData? value) {
    final _$actionInfo = _$SpokenLanguageStoreBaseActionController.startAction(
        name: 'SpokenLanguageStoreBase.setSpokenLanguages');
    try {
      return super.setSpokenLanguages(value);
    } finally {
      _$SpokenLanguageStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSpokenLanguageLevel(MasterData? value) {
    final _$actionInfo = _$SpokenLanguageStoreBaseActionController.startAction(
        name: 'SpokenLanguageStoreBase.setSpokenLanguageLevel');
    try {
      return super.setSpokenLanguageLevel(value);
    } finally {
      _$SpokenLanguageStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedSpokenLanguageProficiency(MasterData value) {
    final _$actionInfo = _$SpokenLanguageStoreBaseActionController.startAction(
        name: 'SpokenLanguageStoreBase.setSelectedSpokenLanguageProficiency');
    try {
      return super.setSelectedSpokenLanguageProficiency(value);
    } finally {
      _$SpokenLanguageStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cachedSpokenLanguageResponse: ${cachedSpokenLanguageResponse},
spokenLanguages: ${spokenLanguages},
spokenLanguageLevel: ${spokenLanguageLevel},
selectedSpokenLanguageProficiency: ${selectedSpokenLanguageProficiency},
spokenLanguageInitialData: ${spokenLanguageInitialData},
spokenLanguageLevelInitialData: ${spokenLanguageLevelInitialData},
spokenLanguageProficiencyInitialData: ${spokenLanguageProficiencyInitialData},
spokenLanguageFormState: ${spokenLanguageFormState}
    ''';
  }
}
