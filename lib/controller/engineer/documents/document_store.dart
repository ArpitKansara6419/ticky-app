import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/engineer/documents/document_controller.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/engineer/documents/document_response.dart';
import 'package:ticky/utils/config.dart';

part 'document_store.g.dart';

class DocumentStore = DocumentStoreBase with _$DocumentStore;

abstract class DocumentStoreBase with Store {
  @observable
  DocumentResponse? documentData;
  @observable
  String? documentTypeValue;

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
  List<File> documentFiles = ObservableList();

  @action
  Future<void> setDocumentFiles({required List<File> file}) async {
    documentFiles = file;
  }

  @action
  Future<void> setIdDocument(String? value) async {
    documentTypeValue = value.validate().trim();
  }

  @observable
  GlobalKey<FormState> documentFormState = GlobalKey();

  @action
  Future<void> onSubmit() async {
    if (documentFormState.currentState!.validate()) {
      documentFormState.currentState!.save();

      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.documentApiState, value: true);

      Map<String, dynamic> request = {
        "id": "",
        "user_id": userStore.userId,
        "document_type": documentTypeValue.validate().trim(),
        "issue_date": DateFormat(ShowDateFormat.yyyyMmDdDash).format(issueDate!),
        "expiry_date": DateFormat(ShowDateFormat.yyyyMmDdDash).format(expireDate!),
        "status": 1,
      };

      log(request);
      await DocumentController.addDocumentApiMultipart(request: request, files: documentFiles);
    }
  }

  @action
  Future<void> onUpdate({required int id}) async {
    if (documentFormState.currentState!.validate()) {
      documentFormState.currentState!.save();

      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.documentApiState, value: true);

      Map<String, dynamic> request = {
        "id": id,
        "user_id": userStore.userId,
        "document_type": documentTypeValue.validate().trim(),
        "issue_date": DateFormat(ShowDateFormat.yyyyMmDdDash).format(issueDate!),
        "expiry_date": DateFormat(ShowDateFormat.yyyyMmDdDash).format(expireDate!),
        "status": 1,
      };

      log(request);

      await DocumentController.addDocumentApiMultipart(request: request, files: documentFiles);
    }
  }

  @action
  Future<void> deleteDocument({required int id}) async {
    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.documentApiState, value: true);

    await DocumentController.deleteDocumentApi(id: id).then((res) {
      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.documentApiState, value: false);

      toast(res.message.validate());

      // finish(getContext);
    }).catchError((e) {
      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.documentApiState, value: false);
      toast(e.toString(), print: true);
    });

    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.documentApiState, value: false);
  }

  void dispose() {
    documentTypeValue = null;
    issueDateCont.clear();
    issueDate = null;
    expireDateCont.clear();
    expireDate = null;
    fileUploadCont.clear();
    documentFiles.clear();
  }
}
