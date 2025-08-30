// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'technical_skill_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TechnicalSkillStore on TechnicalSkillStoreBase, Store {
  late final _$cachedTechnicalSkillResponseAtom = Atom(
      name: 'TechnicalSkillStoreBase.cachedTechnicalSkillResponse',
      context: context);

  @override
  TechnicalSkillResponse? get cachedTechnicalSkillResponse {
    _$cachedTechnicalSkillResponseAtom.reportRead();
    return super.cachedTechnicalSkillResponse;
  }

  @override
  set cachedTechnicalSkillResponse(TechnicalSkillResponse? value) {
    _$cachedTechnicalSkillResponseAtom
        .reportWrite(value, super.cachedTechnicalSkillResponse, () {
      super.cachedTechnicalSkillResponse = value;
    });
  }

  late final _$skillNameAtom =
      Atom(name: 'TechnicalSkillStoreBase.skillName', context: context);

  @override
  MasterData? get skillName {
    _$skillNameAtom.reportRead();
    return super.skillName;
  }

  @override
  set skillName(MasterData? value) {
    _$skillNameAtom.reportWrite(value, super.skillName, () {
      super.skillName = value;
    });
  }

  late final _$experienceLevelAtom =
      Atom(name: 'TechnicalSkillStoreBase.experienceLevel', context: context);

  @override
  MasterData? get experienceLevel {
    _$experienceLevelAtom.reportRead();
    return super.experienceLevel;
  }

  @override
  set experienceLevel(MasterData? value) {
    _$experienceLevelAtom.reportWrite(value, super.experienceLevel, () {
      super.experienceLevel = value;
    });
  }

  late final _$skillNameInitialDataAtom = Atom(
      name: 'TechnicalSkillStoreBase.skillNameInitialData', context: context);

  @override
  MasterDataResponse? get skillNameInitialData {
    _$skillNameInitialDataAtom.reportRead();
    return super.skillNameInitialData;
  }

  @override
  set skillNameInitialData(MasterDataResponse? value) {
    _$skillNameInitialDataAtom.reportWrite(value, super.skillNameInitialData,
        () {
      super.skillNameInitialData = value;
    });
  }

  late final _$experienceLevelInitialDataAtom = Atom(
      name: 'TechnicalSkillStoreBase.experienceLevelInitialData',
      context: context);

  @override
  MasterDataResponse? get experienceLevelInitialData {
    _$experienceLevelInitialDataAtom.reportRead();
    return super.experienceLevelInitialData;
  }

  @override
  set experienceLevelInitialData(MasterDataResponse? value) {
    _$experienceLevelInitialDataAtom
        .reportWrite(value, super.experienceLevelInitialData, () {
      super.experienceLevelInitialData = value;
    });
  }

  late final _$technicalSkillFormStateAtom = Atom(
      name: 'TechnicalSkillStoreBase.technicalSkillFormState',
      context: context);

  @override
  GlobalKey<FormState> get technicalSkillFormState {
    _$technicalSkillFormStateAtom.reportRead();
    return super.technicalSkillFormState;
  }

  @override
  set technicalSkillFormState(GlobalKey<FormState> value) {
    _$technicalSkillFormStateAtom
        .reportWrite(value, super.technicalSkillFormState, () {
      super.technicalSkillFormState = value;
    });
  }

  late final _$onSubmitAsyncAction =
      AsyncAction('TechnicalSkillStoreBase.onSubmit', context: context);

  @override
  Future<void> onSubmit() {
    return _$onSubmitAsyncAction.run(() => super.onSubmit());
  }

  late final _$onUpdateAsyncAction =
      AsyncAction('TechnicalSkillStoreBase.onUpdate', context: context);

  @override
  Future<void> onUpdate({required int id}) {
    return _$onUpdateAsyncAction.run(() => super.onUpdate(id: id));
  }

  late final _$deleteTechnicalSkillAsyncAction = AsyncAction(
      'TechnicalSkillStoreBase.deleteTechnicalSkill',
      context: context);

  @override
  Future<void> deleteTechnicalSkill({required int id}) {
    return _$deleteTechnicalSkillAsyncAction
        .run(() => super.deleteTechnicalSkill(id: id));
  }

  late final _$TechnicalSkillStoreBaseActionController =
      ActionController(name: 'TechnicalSkillStoreBase', context: context);

  @override
  void setSkillName(MasterData? value) {
    final _$actionInfo = _$TechnicalSkillStoreBaseActionController.startAction(
        name: 'TechnicalSkillStoreBase.setSkillName');
    try {
      return super.setSkillName(value);
    } finally {
      _$TechnicalSkillStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setExperienceLevel(MasterData? value) {
    final _$actionInfo = _$TechnicalSkillStoreBaseActionController.startAction(
        name: 'TechnicalSkillStoreBase.setExperienceLevel');
    try {
      return super.setExperienceLevel(value);
    } finally {
      _$TechnicalSkillStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cachedTechnicalSkillResponse: ${cachedTechnicalSkillResponse},
skillName: ${skillName},
experienceLevel: ${experienceLevel},
skillNameInitialData: ${skillNameInitialData},
experienceLevelInitialData: ${experienceLevelInitialData},
technicalSkillFormState: ${technicalSkillFormState}
    ''';
  }
}
