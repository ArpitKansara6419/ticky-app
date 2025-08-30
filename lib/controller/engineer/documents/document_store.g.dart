// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DocumentStore on DocumentStoreBase, Store {
  late final _$documentDataAtom =
      Atom(name: 'DocumentStoreBase.documentData', context: context);

  @override
  DocumentResponse? get documentData {
    _$documentDataAtom.reportRead();
    return super.documentData;
  }

  @override
  set documentData(DocumentResponse? value) {
    _$documentDataAtom.reportWrite(value, super.documentData, () {
      super.documentData = value;
    });
  }

  late final _$documentTypeValueAtom =
      Atom(name: 'DocumentStoreBase.documentTypeValue', context: context);

  @override
  String? get documentTypeValue {
    _$documentTypeValueAtom.reportRead();
    return super.documentTypeValue;
  }

  @override
  set documentTypeValue(String? value) {
    _$documentTypeValueAtom.reportWrite(value, super.documentTypeValue, () {
      super.documentTypeValue = value;
    });
  }

  late final _$issueDateContAtom =
      Atom(name: 'DocumentStoreBase.issueDateCont', context: context);

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
      Atom(name: 'DocumentStoreBase.issueDate', context: context);

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
      Atom(name: 'DocumentStoreBase.expireDateCont', context: context);

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
      Atom(name: 'DocumentStoreBase.expireDate', context: context);

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
      Atom(name: 'DocumentStoreBase.fileUploadCont', context: context);

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

  late final _$documentFilesAtom =
      Atom(name: 'DocumentStoreBase.documentFiles', context: context);

  @override
  List<File> get documentFiles {
    _$documentFilesAtom.reportRead();
    return super.documentFiles;
  }

  @override
  set documentFiles(List<File> value) {
    _$documentFilesAtom.reportWrite(value, super.documentFiles, () {
      super.documentFiles = value;
    });
  }

  late final _$documentFormStateAtom =
      Atom(name: 'DocumentStoreBase.documentFormState', context: context);

  @override
  GlobalKey<FormState> get documentFormState {
    _$documentFormStateAtom.reportRead();
    return super.documentFormState;
  }

  @override
  set documentFormState(GlobalKey<FormState> value) {
    _$documentFormStateAtom.reportWrite(value, super.documentFormState, () {
      super.documentFormState = value;
    });
  }

  late final _$setDocumentFilesAsyncAction =
      AsyncAction('DocumentStoreBase.setDocumentFiles', context: context);

  @override
  Future<void> setDocumentFiles({required List<File> file}) {
    return _$setDocumentFilesAsyncAction
        .run(() => super.setDocumentFiles(file: file));
  }

  late final _$setIdDocumentAsyncAction =
      AsyncAction('DocumentStoreBase.setIdDocument', context: context);

  @override
  Future<void> setIdDocument(String? value) {
    return _$setIdDocumentAsyncAction.run(() => super.setIdDocument(value));
  }

  late final _$onSubmitAsyncAction =
      AsyncAction('DocumentStoreBase.onSubmit', context: context);

  @override
  Future<void> onSubmit() {
    return _$onSubmitAsyncAction.run(() => super.onSubmit());
  }

  late final _$onUpdateAsyncAction =
      AsyncAction('DocumentStoreBase.onUpdate', context: context);

  @override
  Future<void> onUpdate({required int id}) {
    return _$onUpdateAsyncAction.run(() => super.onUpdate(id: id));
  }

  late final _$deleteDocumentAsyncAction =
      AsyncAction('DocumentStoreBase.deleteDocument', context: context);

  @override
  Future<void> deleteDocument({required int id}) {
    return _$deleteDocumentAsyncAction.run(() => super.deleteDocument(id: id));
  }

  @override
  String toString() {
    return '''
documentData: ${documentData},
documentTypeValue: ${documentTypeValue},
issueDateCont: ${issueDateCont},
issueDate: ${issueDate},
expireDateCont: ${expireDateCont},
expireDate: ${expireDate},
fileUploadCont: ${fileUploadCont},
documentFiles: ${documentFiles},
documentFormState: ${documentFormState}
    ''';
  }
}
