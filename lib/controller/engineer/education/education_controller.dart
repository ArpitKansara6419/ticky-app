import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/engineer/education/add_education_response.dart';
import 'package:ticky/model/engineer/education/education_response.dart';
import 'package:ticky/network/api_client.dart';
import 'package:ticky/utils/config.dart';

class EducationController {
  static Future<EducationResponse> getEducationListApi() async {
    var res = EducationResponse.fromJson(await handleResponse(await buildHttpResponse(EducationEndPoints.educationListUrl + userStore.userId.validate().toString())));

    educationStore.cachedEducationResponse = res;

    return res;
  }

  static Future<AddEducationResponse> addEducationApiMultipart({required Map<String, dynamic> request, List<File>? files}) async {
    MultipartRequest multiPartRequest = await getMultiPartRequest(EducationEndPoints.saveEducationUrl);

    request.forEach((key, value) {
      multiPartRequest.fields[key] = value.toString();
    });

    if (files.validate().isNotEmpty && files.validate().any((e) => !e.path.contains("http"))) {
      await Future.forEach<File>(files!, (element) async {
        multiPartRequest.files.add(await MultipartFile.fromPath("media_files" + '[${files.indexOf(element)}]', element.path));
      });
    }

    log("Request ${multiPartRequest.fields}");
    log("Request ${multiPartRequest.files.map((e) => e.field)}");

    multiPartRequest.headers.addAll(buildHeaderTokens());

    await sendMultiPartRequest(
      multiPartRequest,
      onSuccess: (data) async {
        appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addEducationApiState, value: false);
        AddEducationResponse res = AddEducationResponse.fromJson(jsonDecode(data));

        toast(res.message.validate(), print: true);
        finish(getContext, true);
      },
      onError: (error) {
        toast(error.toString(), print: true);
      },
    ).whenComplete(() => appLoaderStore.setLoaderValue(appState: AppLoaderStateName.addEducationApiState, value: false));

    return AddEducationResponse();
  }

  static Future<AddEducationResponse> deleteEducationApi({required int id}) async {
    AddEducationResponse res = AddEducationResponse.fromJson(await handleResponse(await buildHttpResponse(EducationEndPoints.deleteEducationURl + "$id", method: HttpMethod.POST)));
    return res;
  }
}
