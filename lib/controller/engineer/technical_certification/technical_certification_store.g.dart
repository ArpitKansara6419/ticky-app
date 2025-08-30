// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'technical_certification_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TechnicalCertificationStore on TechnicalCertificationStoreBase, Store {
  late final _$cachedTechnicalSkillResponseAtom = Atom(
      name: 'TechnicalCertificationStoreBase.cachedTechnicalSkillResponse',
      context: context);

  @override
  TechnicalCertificationResponse? get cachedTechnicalSkillResponse {
    _$cachedTechnicalSkillResponseAtom.reportRead();
    return super.cachedTechnicalSkillResponse;
  }

  @override
  set cachedTechnicalSkillResponse(TechnicalCertificationResponse? value) {
    _$cachedTechnicalSkillResponseAtom
        .reportWrite(value, super.cachedTechnicalSkillResponse, () {
      super.cachedTechnicalSkillResponse = value;
    });
  }

  late final _$certificateNameAtom = Atom(
      name: 'TechnicalCertificationStoreBase.certificateName',
      context: context);

  @override
  MasterData? get certificateName {
    _$certificateNameAtom.reportRead();
    return super.certificateName;
  }

  @override
  set certificateName(MasterData? value) {
    _$certificateNameAtom.reportWrite(value, super.certificateName, () {
      super.certificateName = value;
    });
  }

  late final _$certificateInitialDataAtom = Atom(
      name: 'TechnicalCertificationStoreBase.certificateInitialData',
      context: context);

  @override
  MasterDataResponse? get certificateInitialData {
    _$certificateInitialDataAtom.reportRead();
    return super.certificateInitialData;
  }

  @override
  set certificateInitialData(MasterDataResponse? value) {
    _$certificateInitialDataAtom
        .reportWrite(value, super.certificateInitialData, () {
      super.certificateInitialData = value;
    });
  }

  late final _$certificateIdContAtom = Atom(
      name: 'TechnicalCertificationStoreBase.certificateIdCont',
      context: context);

  @override
  TextEditingController get certificateIdCont {
    _$certificateIdContAtom.reportRead();
    return super.certificateIdCont;
  }

  @override
  set certificateIdCont(TextEditingController value) {
    _$certificateIdContAtom.reportWrite(value, super.certificateIdCont, () {
      super.certificateIdCont = value;
    });
  }

  late final _$issueDateAtom =
      Atom(name: 'TechnicalCertificationStoreBase.issueDate', context: context);

  @override
  DateTime? get issueDate {
    _$issueDateAtom.reportRead();
    return super.issueDate;
  }

  @override
  set issueDate(DateTime? value) {
    _$issueDateAtom.reportWrite(value, super.issueDate, () {
      super.issueDate = value;
    });
  }

  late final _$issueDateContAtom = Atom(
      name: 'TechnicalCertificationStoreBase.issueDateCont', context: context);

  @override
  TextEditingController get issueDateCont {
    _$issueDateContAtom.reportRead();
    return super.issueDateCont;
  }

  @override
  set issueDateCont(TextEditingController value) {
    _$issueDateContAtom.reportWrite(value, super.issueDateCont, () {
      super.issueDateCont = value;
    });
  }

  late final _$expireDateAtom = Atom(
      name: 'TechnicalCertificationStoreBase.expireDate', context: context);

  @override
  DateTime? get expireDate {
    _$expireDateAtom.reportRead();
    return super.expireDate;
  }

  @override
  set expireDate(DateTime? value) {
    _$expireDateAtom.reportWrite(value, super.expireDate, () {
      super.expireDate = value;
    });
  }

  late final _$expireDateContAtom = Atom(
      name: 'TechnicalCertificationStoreBase.expireDateCont', context: context);

  @override
  TextEditingController get expireDateCont {
    _$expireDateContAtom.reportRead();
    return super.expireDateCont;
  }

  @override
  set expireDateCont(TextEditingController value) {
    _$expireDateContAtom.reportWrite(value, super.expireDateCont, () {
      super.expireDateCont = value;
    });
  }

  late final _$fileUploadContAtom = Atom(
      name: 'TechnicalCertificationStoreBase.fileUploadCont', context: context);

  @override
  TextEditingController get fileUploadCont {
    _$fileUploadContAtom.reportRead();
    return super.fileUploadCont;
  }

  @override
  set fileUploadCont(TextEditingController value) {
    _$fileUploadContAtom.reportWrite(value, super.fileUploadCont, () {
      super.fileUploadCont = value;
    });
  }

  late final _$recentlyUpdatedFilesAtom = Atom(
      name: 'TechnicalCertificationStoreBase.recentlyUpdatedFiles',
      context: context);

  @override
  List<File> get recentlyUpdatedFiles {
    _$recentlyUpdatedFilesAtom.reportRead();
    return super.recentlyUpdatedFiles;
  }

  @override
  set recentlyUpdatedFiles(List<File> value) {
    _$recentlyUpdatedFilesAtom.reportWrite(value, super.recentlyUpdatedFiles,
        () {
      super.recentlyUpdatedFiles = value;
    });
  }

  late final _$technicalCertificationFormStateAtom = Atom(
      name: 'TechnicalCertificationStoreBase.technicalCertificationFormState',
      context: context);

  @override
  GlobalKey<FormState> get technicalCertificationFormState {
    _$technicalCertificationFormStateAtom.reportRead();
    return super.technicalCertificationFormState;
  }

  @override
  set technicalCertificationFormState(GlobalKey<FormState> value) {
    _$technicalCertificationFormStateAtom
        .reportWrite(value, super.technicalCertificationFormState, () {
      super.technicalCertificationFormState = value;
    });
  }

  late final _$setDocumentFilesAsyncAction = AsyncAction(
      'TechnicalCertificationStoreBase.setDocumentFiles',
      context: context);

  @override
  Future<void> setDocumentFiles({required List<File> file}) {
    return _$setDocumentFilesAsyncAction
        .run(() => super.setDocumentFiles(file: file));
  }

  late final _$onSubmitAsyncAction =
      AsyncAction('TechnicalCertificationStoreBase.onSubmit', context: context);

  @override
  Future<void> onSubmit() {
    return _$onSubmitAsyncAction.run(() => super.onSubmit());
  }

  late final _$onUpdateAsyncAction =
      AsyncAction('TechnicalCertificationStoreBase.onUpdate', context: context);

  @override
  Future<void> onUpdate({required int id}) {
    return _$onUpdateAsyncAction.run(() => super.onUpdate(id: id));
  }

  late final _$deleteTechnicalSkillAsyncAction = AsyncAction(
      'TechnicalCertificationStoreBase.deleteTechnicalSkill',
      context: context);

  @override
  Future<void> deleteTechnicalSkill({required int id}) {
    return _$deleteTechnicalSkillAsyncAction
        .run(() => super.deleteTechnicalSkill(id: id));
  }

  late final _$TechnicalCertificationStoreBaseActionController =
      ActionController(
          name: 'TechnicalCertificationStoreBase', context: context);

  @override
  void setCertificateName(MasterData? value) {
    final _$actionInfo =
        _$TechnicalCertificationStoreBaseActionController.startAction(
            name: 'TechnicalCertificationStoreBase.setCertificateName');
    try {
      return super.setCertificateName(value);
    } finally {
      _$TechnicalCertificationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cachedTechnicalSkillResponse: ${cachedTechnicalSkillResponse},
certificateName: ${certificateName},
certificateInitialData: ${certificateInitialData},
certificateIdCont: ${certificateIdCont},
issueDate: ${issueDate},
issueDateCont: ${issueDateCont},
expireDate: ${expireDate},
expireDateCont: ${expireDateCont},
fileUploadCont: ${fileUploadCont},
recentlyUpdatedFiles: ${recentlyUpdatedFiles},
technicalCertificationFormState: ${technicalCertificationFormState}
    ''';
  }
}
