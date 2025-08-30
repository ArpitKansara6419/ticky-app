import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/engineer/documents/add_document_response.dart';
import 'package:ticky/model/engineer/documents/document_response.dart';
import 'package:ticky/network/api_client.dart';
import 'package:ticky/utils/config.dart';

class DocumentController {
  static Future<DocumentResponse> getDocumentListApi() async {
    var res = DocumentResponse.fromJson(await handleResponse(await buildHttpResponse(DocumentEndPoints.documentListUrl + "/${userStore.userId}")));

    documentStore.documentData = res;

    return res;
  }

  static Future<AddDocumentResponse> addDocumentApiMultipart({required Map<String, dynamic> request, List<File>? files}) async {
    MultipartRequest multiPartRequest = await getMultiPartRequest(DocumentEndPoints.saveDocumentUrl);

    request.forEach((key, value) {
      multiPartRequest.fields[key] = value.toString();
    });

    if (files.validate().isNotEmpty && files.validate().any((e) => !e.path.contains("http"))) {
      await Future.forEach<File>(files!, (element) async {
        multiPartRequest.files.add(await MultipartFile.fromPath("media_files" + '[${files.indexOf(element)}]', element.path));
      });
    }

    log("Request ${multiPartRequest.fields}");
    log("Request ${multiPartRequest.files.length}");

    multiPartRequest.headers.addAll(buildHeaderTokens());

    sendMultiPartRequest(
      multiPartRequest,
      onSuccess: (data) async {
        appLoaderStore.setLoaderValue(appState: AppLoaderStateName.documentApiState, value: false);
        AddDocumentResponse res = AddDocumentResponse.fromJson(jsonDecode(data));

        toast(res.message.validate(), print: true);
        finish(getContext, true);
      },
      onError: (error) {
        toast(error.toString(), print: true);
      },
    ).whenComplete(() => appLoaderStore.setLoaderValue(appState: AppLoaderStateName.documentApiState, value: false));

    return AddDocumentResponse();
    // AddDocumentResponse res = AddDocumentResponse.fromJson(await handleResponse(await buildHttpResponse(DocumentEndPoints.saveDocumentUrl, request: request, method: HttpMethod.POST)));
    // return res;
  }

  static Future<AddDocumentResponse> deleteDocumentApi({required int id}) async {
    AddDocumentResponse res = AddDocumentResponse.fromJson(await handleResponse(await buildHttpResponse(DocumentEndPoints.deleteDocumentURl + "/$id", method: HttpMethod.POST)));
    return res;
  }
}
