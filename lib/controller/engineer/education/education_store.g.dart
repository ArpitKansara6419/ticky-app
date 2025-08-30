// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'education_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EducationStore on EducationStoreBase, Store {
  late final _$cachedEducationResponseAtom = Atom(
      name: 'EducationStoreBase.cachedEducationResponse', context: context);

  @override
  EducationResponse? get cachedEducationResponse {
    _$cachedEducationResponseAtom.reportRead();
    return super.cachedEducationResponse;
  }

  @override
  set cachedEducationResponse(EducationResponse? value) {
    _$cachedEducationResponseAtom
        .reportWrite(value, super.cachedEducationResponse, () {
      super.cachedEducationResponse = value;
    });
  }

  late final _$nameOfDegreeContAtom =
      Atom(name: 'EducationStoreBase.nameOfDegreeCont', context: context);

  @override
  TextEditingController get nameOfDegreeCont {
    _$nameOfDegreeContAtom.reportRead();
    return super.nameOfDegreeCont;
  }

  @override
  set nameOfDegreeCont(TextEditingController value) {
    _$nameOfDegreeContAtom.reportWrite(value, super.nameOfDegreeCont, () {
      super.nameOfDegreeCont = value;
    });
  }

  late final _$universityNameContAtom =
      Atom(name: 'EducationStoreBase.universityNameCont', context: context);

  @override
  TextEditingController get universityNameCont {
    _$universityNameContAtom.reportRead();
    return super.universityNameCont;
  }

  @override
  set universityNameCont(TextEditingController value) {
    _$universityNameContAtom.reportWrite(value, super.universityNameCont, () {
      super.universityNameCont = value;
    });
  }

  late final _$issueDateContAtom =
      Atom(name: 'EducationStoreBase.issueDateCont', context: context);

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

  late final _$issueDateAtom =
      Atom(name: 'EducationStoreBase.issueDate', context: context);

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

  late final _$expireDateContAtom =
      Atom(name: 'EducationStoreBase.expireDateCont', context: context);

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

  late final _$expireDateAtom =
      Atom(name: 'EducationStoreBase.expireDate', context: context);

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

  late final _$fileUploadContAtom =
      Atom(name: 'EducationStoreBase.fileUploadCont', context: context);

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

  late final _$educationFilesAtom =
      Atom(name: 'EducationStoreBase.educationFiles', context: context);

  @override
  List<File> get educationFiles {
    _$educationFilesAtom.reportRead();
    return super.educationFiles;
  }

  @override
  set educationFiles(List<File> value) {
    _$educationFilesAtom.reportWrite(value, super.educationFiles, () {
      super.educationFiles = value;
    });
  }

  late final _$educationFormStateAtom =
      Atom(name: 'EducationStoreBase.educationFormState', context: context);

  @override
  GlobalKey<FormState> get educationFormState {
    _$educationFormStateAtom.reportRead();
    return super.educationFormState;
  }

  @override
  set educationFormState(GlobalKey<FormState> value) {
    _$educationFormStateAtom.reportWrite(value, super.educationFormState, () {
      super.educationFormState = value;
    });
  }

  late final _$nameOfDegreeFocusNodeAtom =
      Atom(name: 'EducationStoreBase.nameOfDegreeFocusNode', context: context);

  @override
  FocusNode get nameOfDegreeFocusNode {
    _$nameOfDegreeFocusNodeAtom.reportRead();
    return super.nameOfDegreeFocusNode;
  }

  @override
  set nameOfDegreeFocusNode(FocusNode value) {
    _$nameOfDegreeFocusNodeAtom.reportWrite(value, super.nameOfDegreeFocusNode,
        () {
      super.nameOfDegreeFocusNode = value;
    });
  }

  late final _$universityNameFocusNodeAtom = Atom(
      name: 'EducationStoreBase.universityNameFocusNode', context: context);

  @override
  FocusNode get universityNameFocusNode {
    _$universityNameFocusNodeAtom.reportRead();
    return super.universityNameFocusNode;
  }

  @override
  set universityNameFocusNode(FocusNode value) {
    _$universityNameFocusNodeAtom
        .reportWrite(value, super.universityNameFocusNode, () {
      super.universityNameFocusNode = value;
    });
  }

  late final _$setEducationFilesAsyncAction =
      AsyncAction('EducationStoreBase.setEducationFiles', context: context);

  @override
  Future<void> setEducationFiles({required List<File> file}) {
    return _$setEducationFilesAsyncAction
        .run(() => super.setEducationFiles(file: file));
  }

  late final _$onSubmitAsyncAction =
      AsyncAction('EducationStoreBase.onSubmit', context: context);

  @override
  Future<void> onSubmit() {
    return _$onSubmitAsyncAction.run(() => super.onSubmit());
  }

  late final _$onUpdateAsyncAction =
      AsyncAction('EducationStoreBase.onUpdate', context: context);

  @override
  Future<void> onUpdate({required int id}) {
    return _$onUpdateAsyncAction.run(() => super.onUpdate(id: id));
  }

  late final _$deleteEducationAsyncAction =
      AsyncAction('EducationStoreBase.deleteEducation', context: context);

  @override
  Future<void> deleteEducation({required int id}) {
    return _$deleteEducationAsyncAction
        .run(() => super.deleteEducation(id: id));
  }

  @override
  String toString() {
    return '''
cachedEducationResponse: ${cachedEducationResponse},
nameOfDegreeCont: ${nameOfDegreeCont},
universityNameCont: ${universityNameCont},
issueDateCont: ${issueDateCont},
issueDate: ${issueDate},
expireDateCont: ${expireDateCont},
expireDate: ${expireDate},
fileUploadCont: ${fileUploadCont},
educationFiles: ${educationFiles},
educationFormState: ${educationFormState},
nameOfDegreeFocusNode: ${nameOfDegreeFocusNode},
universityNameFocusNode: ${universityNameFocusNode}
    ''';
  }
}
