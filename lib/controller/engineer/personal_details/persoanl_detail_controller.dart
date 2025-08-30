import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/auth/login_response.dart';
import 'package:ticky/model/auth/user_data.dart';
import 'package:ticky/network/api_client.dart';
import 'package:ticky/utils/config.dart';

class PersonalDetailController {
  static Future<LoginResponse> addPersonalDetailApi({required Map<String, dynamic> request}) async {
    LoginResponse res = LoginResponse.fromJson(await handleResponse(await buildHttpResponse(AuthApiEndpoints.updateUserUrl + "/${userStore.userId}", request: request, method: HttpMethod.POST)));
    return res;
  }

  static Future<LoginResponse> updateProfilePictureApi({List<File>? files}) async {
    MultipartRequest multiPartRequest = await getMultiPartRequest(AuthApiEndpoints.updateProfileUrl + "/${userStore.userId}");

    if (files.validate().isNotEmpty && files.validate().any((e) => !e.path.contains("http"))) {
      await Future.forEach<File>(files!, (element) async {
        multiPartRequest.files.add(await MultipartFile.fromPath("profile_image", element.path));
      });
    }

    log("Request ${multiPartRequest.fields}");
    log("Request ${multiPartRequest.files.map((e) => e.field)}");

    multiPartRequest.headers.addAll(buildHeaderTokens());

    await sendMultiPartRequest(
      multiPartRequest,
      onSuccess: (data) async {
        LoginResponse res = LoginResponse.fromJson(jsonDecode(data));
        userStore.setProfileImage(Config.imageUrl + res.userData!.profileImage.validate());
        toast(res.message.validate(), print: true);
      },
      onError: (error) {
        personalDetailsStore.setProfilePictureFiles(file: []);
        toast("Failed to upload the profile picture. Please try again later.", print: true, textColor: Colors.red);
      },
    ).whenComplete(() => appLoaderStore.setLoaderValue(appState: AppLoaderStateName.personalDataApiState, value: false));

    return LoginResponse();
  }

  static Future<LoginResponse> updateMobileVerifiedApi({required int value}) async {
    MultipartRequest multiPartRequest = await getMultiPartRequest(AuthApiEndpoints.updateProfileUrl + "/${userStore.userId}");

    multiPartRequest.fields['phone_verification'] = value.validate().toString();

    log("Request ${multiPartRequest.fields}");
    log("Request ${multiPartRequest.files.map((e) => e.field)}");

    multiPartRequest.headers.addAll(buildHeaderTokens());

    await sendMultiPartRequest(
      multiPartRequest,
      onSuccess: (data) async {
        LoginResponse res = LoginResponse.fromJson(jsonDecode(data));
        userStore.setProfileImage(Config.imageUrl + res.userData!.profileImage.validate());
        userStore.setPhoneNumberVerified(true);
        toast(res.message.validate(), print: true);
      },
      onError: (error) {
        personalDetailsStore.setProfilePictureFiles(file: []);
        toast("Failed to upload the profile picture. Please try again later.", print: true, textColor: Colors.red);
      },
    ).whenComplete(() => appLoaderStore.setLoaderValue(appState: AppLoaderStateName.personalDataApiState, value: false));

    return LoginResponse();
  }

  static Future<LoginResponse> updateGdprConsentApi({required int value}) async {
    MultipartRequest multiPartRequest = await getMultiPartRequest(AuthApiEndpoints.updateProfileUrl + "/${userStore.userId}");

    multiPartRequest.fields['gdpr_consent'] = value.validate().toString();

    log("Request ${multiPartRequest.fields}");
    log("Request ${multiPartRequest.files.map((e) => e.field)}");

    multiPartRequest.headers.addAll(buildHeaderTokens());

    await sendMultiPartRequest(
      multiPartRequest,
      onSuccess: (data) async {
        LoginResponse res = LoginResponse.fromJson(jsonDecode(data));
        userStore.setGdprConsentVerified(res.userData!.gdprConsent.validate());
        toast(res.message.validate(), print: true);
      },
      onError: (error) {
        personalDetailsStore.setProfilePictureFiles(file: []);
      },
    ).whenComplete(() => appLoaderStore.setLoaderValue(appState: AppLoaderStateName.personalDataApiState, value: false));

    return LoginResponse();
  }

  static Future<User> getUserDataApi() async {
    LoginResponse res = LoginResponse.fromJson(await handleResponse(await buildHttpResponse(AuthApiEndpoints.getUserUrl + "/${userStore.userId}")));

    return res.userData!;
  }
}
