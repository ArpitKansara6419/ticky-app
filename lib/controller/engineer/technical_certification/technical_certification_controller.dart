import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/engineer/technical_certification/add_technical_certification_response.dart';
import 'package:ticky/model/engineer/technical_certification/technical_certification_response.dart';
import 'package:ticky/network/api_client.dart';
import 'package:ticky/utils/config.dart';

class TechnicalCertificationController {
  static Future<TechnicalCertificationResponse> getTechnicalCertificationListApi() async {
    var res = TechnicalCertificationResponse.fromJson(await handleResponse(await buildHttpResponse(TechnicalCertificationEndPoints.technicalCertificationListUrl + "/${userStore.userId}")));

    return res;
  }

  static Future<AddTechnicalCertificationResponse> addTechnicalCertificationApiOlt({required Map<String, dynamic> request}) async {
    log("Request $request");
    AddTechnicalCertificationResponse res = AddTechnicalCertificationResponse.fromJson(
      await handleResponse(await buildHttpResponse(TechnicalCertificationEndPoints.saveTechnicalCertificationUrl, request: request, method: HttpMethod.POST)),
    );
    return res;
  }

  static Future<AddTechnicalCertificationResponse> addTechnicalCertificationApi({required Map<String, dynamic> request, List<File>? files}) async {
    MultipartRequest multiPartRequest = await getMultiPartRequest(TechnicalCertificationEndPoints.saveTechnicalCertificationUrl);

    request.forEach((key, value) {
      multiPartRequest.fields[key] = value.toString();
    });

    if (files.validate().isNotEmpty && files.validate().any((e) => !e.path.contains("http"))) {
      await Future.forEach<File>(files!, (element) async {
        multiPartRequest.files.add(await MultipartFile.fromPath("certificate_file", element.path));
      });
    }

    log("Request ${multiPartRequest.fields}");
    log("Request ${multiPartRequest.files.map((e) => e.field)}");

    multiPartRequest.headers.addAll(buildHeaderTokens());

    await sendMultiPartRequest(
      multiPartRequest,
      onSuccess: (data) async {
        appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addEducationApiState, value: false);
        AddTechnicalCertificationResponse res = AddTechnicalCertificationResponse.fromJson(jsonDecode(data));

        toast(res.message.validate(), print: true);
        finish(getContext, true);
      },
      onError: (error) {
        toast(error.toString(), print: true);
      },
    ).whenComplete(() => appLoaderStore.setLoaderValue(appState: AppLoaderStateName.documentApiState, value: false));

    return AddTechnicalCertificationResponse();
  }

  static Future<AddTechnicalCertificationResponse> deleteTechnicalCertificationApi({required int id}) async {
    AddTechnicalCertificationResponse res =
        AddTechnicalCertificationResponse.fromJson(await handleResponse(await buildHttpResponse(TechnicalCertificationEndPoints.deleteTechnicalCertificationURl + "?id=$id", method: HttpMethod.POST)));
    return res;
  }
}
