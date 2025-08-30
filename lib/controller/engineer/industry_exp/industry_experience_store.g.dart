// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'industry_experience_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$IndustryExperienceStore on IndustryExperienceStoreBase, Store {
  late final _$cachedIndustryExperienceResponseAtom = Atom(
      name: 'IndustryExperienceStoreBase.cachedIndustryExperienceResponse',
      context: context);

  @override
  IndustryExperienceResponse? get cachedIndustryExperienceResponse {
    _$cachedIndustryExperienceResponseAtom.reportRead();
    return super.cachedIndustryExperienceResponse;
  }

  @override
  set cachedIndustryExperienceResponse(IndustryExperienceResponse? value) {
    _$cachedIndustryExperienceResponseAtom
        .reportWrite(value, super.cachedIndustryExperienceResponse, () {
      super.cachedIndustryExperienceResponse = value;
    });
  }

  late final _$industryNameInitialDataAtom = Atom(
      name: 'IndustryExperienceStoreBase.industryNameInitialData',
      context: context);

  @override
  MasterDataResponse? get industryNameInitialData {
    _$industryNameInitialDataAtom.reportRead();
    return super.industryNameInitialData;
  }

  @override
  set industryNameInitialData(MasterDataResponse? value) {
    _$industryNameInitialDataAtom
        .reportWrite(value, super.industryNameInitialData, () {
      super.industryNameInitialData = value;
    });
  }

  late final _$industryLevelInitialDataAtom = Atom(
      name: 'IndustryExperienceStoreBase.industryLevelInitialData',
      context: context);

  @override
  MasterDataResponse? get industryLevelInitialData {
    _$industryLevelInitialDataAtom.reportRead();
    return super.industryLevelInitialData;
  }

  @override
  set industryLevelInitialData(MasterDataResponse? value) {
    _$industryLevelInitialDataAtom
        .reportWrite(value, super.industryLevelInitialData, () {
      super.industryLevelInitialData = value;
    });
  }

  late final _$industryNameAtom =
      Atom(name: 'IndustryExperienceStoreBase.industryName', context: context);

  @override
  MasterData? get industryName {
    _$industryNameAtom.reportRead();
    return super.industryName;
  }

  @override
  set industryName(MasterData? value) {
    _$industryNameAtom.reportWrite(value, super.industryName, () {
      super.industryName = value;
    });
  }

  late final _$industryLevelAtom =
      Atom(name: 'IndustryExperienceStoreBase.industryLevel', context: context);

  @override
  MasterData? get industryLevel {
    _$industryLevelAtom.reportRead();
    return super.industryLevel;
  }

  @override
  set industryLevel(MasterData? value) {
    _$industryLevelAtom.reportWrite(value, super.industryLevel, () {
      super.industryLevel = value;
    });
  }

  late final _$industryExperienceFormStateAtom = Atom(
      name: 'IndustryExperienceStoreBase.industryExperienceFormState',
      context: context);

  @override
  GlobalKey<FormState> get industryExperienceFormState {
    _$industryExperienceFormStateAtom.reportRead();
    return super.industryExperienceFormState;
  }

  @override
  set industryExperienceFormState(GlobalKey<FormState> value) {
    _$industryExperienceFormStateAtom
        .reportWrite(value, super.industryExperienceFormState, () {
      super.industryExperienceFormState = value;
    });
  }

  late final _$onSubmitAsyncAction =
      AsyncAction('IndustryExperienceStoreBase.onSubmit', context: context);

  @override
  Future<void> onSubmit() {
    return _$onSubmitAsyncAction.run(() => super.onSubmit());
  }

  late final _$onUpdateAsyncAction =
      AsyncAction('IndustryExperienceStoreBase.onUpdate', context: context);

  @override
  Future<void> onUpdate({required int id}) {
    return _$onUpdateAsyncAction.run(() => super.onUpdate(id: id));
  }

  late final _$deleteIndustryExperienceAsyncAction = AsyncAction(
      'IndustryExperienceStoreBase.deleteIndustryExperience',
      context: context);

  @override
  Future<void> deleteIndustryExperience({required int id}) {
    return _$deleteIndustryExperienceAsyncAction
        .run(() => super.deleteIndustryExperience(id: id));
  }

  late final _$IndustryExperienceStoreBaseActionController =
      ActionController(name: 'IndustryExperienceStoreBase', context: context);

  @override
  void setIndustryName(MasterData? value) {
    final _$actionInfo = _$IndustryExperienceStoreBaseActionController
        .startAction(name: 'IndustryExperienceStoreBase.setIndustryName');
    try {
      return super.setIndustryName(value);
    } finally {
      _$IndustryExperienceStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIndustryLevel(MasterData? value) {
    final _$actionInfo = _$IndustryExperienceStoreBaseActionController
        .startAction(name: 'IndustryExperienceStoreBase.setIndustryLevel');
    try {
      return super.setIndustryLevel(value);
    } finally {
      _$IndustryExperienceStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cachedIndustryExperienceResponse: ${cachedIndustryExperienceResponse},
industryNameInitialData: ${industryNameInitialData},
industryLevelInitialData: ${industryLevelInitialData},
industryName: ${industryName},
industryLevel: ${industryLevel},
industryExperienceFormState: ${industryExperienceFormState}
    ''';
  }
}
