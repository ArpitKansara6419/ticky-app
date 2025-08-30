import 'dart:convert';

import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/engineer/documents/add_document_response.dart';
import 'package:ticky/model/engineer/right_to_work/right_to_work_response.dart';
import 'package:ticky/network/api_client.dart';
import 'package:ticky/utils/config.dart';

class RightController {
  static Future<RightToWorkResponse> getRightToWorkListApi() async {
    RightToWorkResponse res = RightToWorkResponse.fromJson(await handleResponse(await buildHttpResponse(RightToWorkEndPoints.rightToWorkListUrl + "/${userStore.userId}")));

    // documentStore.documentData = res;

    return res;
  }

  static Future<AddDocumentResponse> addRightToWorkApiMultipart({required MultipartRequest multipartRequest}) async {
    log("Request ${multipartRequest.fields}");
    log("Request ${multipartRequest.files.length}");

    multipartRequest.headers.addAll(buildHeaderTokens());

    sendMultiPartRequest(
      multipartRequest,
      onSuccess: (data) async {
        appLoaderStore.setLoaderValue(appState: AppLoaderStateName.rightToWorkApiState, value: false);
        AddDocumentResponse res = AddDocumentResponse.fromJson(jsonDecode(data));

        toast(res.message.validate(), print: true);
        finish(getContext, true);
      },
      onError: (error) {
        toast(error.toString(), print: true);
      },
    ).whenComplete(() => appLoaderStore.setLoaderValue(appState: AppLoaderStateName.rightToWorkApiState, value: false));

    return AddDocumentResponse();
  }
}
