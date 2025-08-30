import 'dart:convert';

import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/auth/login_response.dart';
import 'package:ticky/model/auth/otp_success_response.dart';
import 'package:ticky/model/auth/profile_completion_response.dart';
import 'package:ticky/model/auth/timezone_response.dart';
import 'package:ticky/network/api_client.dart';
import 'package:ticky/utils/config.dart';
import 'package:ticky/utils/enums.dart';

class AuthApiController {
  static Future<LoginResponse> loginApi({required Map<String, dynamic> request}) async {
    LoginResponse res = LoginResponse.fromJson(await handleResponse(await buildHttpResponse(AuthApiEndpoints.loginApiUrl, request: request, method: HttpMethod.POST)));
    return res;
  }

  static Future<LogoutResponse> logoutApi() async {
    LogoutResponse res = LogoutResponse.fromJson(await handleResponse(await buildHttpResponse(AuthApiEndpoints.logoutApiUrl, method: HttpMethod.GET)));
    return res;
  }

  static Future<LogoutResponse> updateTokenApi({required String token}) async {
    Map<String, dynamic> request = {
      "device_token": token,
    };
    log("request => ${jsonEncode(request)}");
    LogoutResponse res = LogoutResponse.fromJson(
      await handleResponse(
        await buildHttpResponse(
          AuthApiEndpoints.updateDeviceToken,
          method: HttpMethod.POST,
          request: request,
        ),
      ),
    );
    return res;
  }

  static Future<LoginResponse> getUserDetailApi({bool isSaveDetail = false, bool isCheckToken = false}) async {
    LoginResponse res = LoginResponse.fromJson(await handleResponse(await buildHttpResponse(AuthApiEndpoints.getUserUrl + "/${userStore.userId}", method: HttpMethod.GET)));

    mainLog(message: jsonEncode(res.toJson()), label: 'LoginResponse => ');
    if (res.userData != null) {
      userStore.setJobType(res.userData!.jobType.validate());
    }
    userStore.lastUpdatedUserValue = res;

    if (isSaveDetail) {
      signupStore.saveUserDataToPreference(isLoginSave: false, loginData: res);
    }

    if (isCheckToken) {
      if (res.userData!.deviceToken == null)
        await AuthApiController.updateTokenApi(token: userStore.firebaseToken.validate()).then((value) {
          userStore.setFirebaseToken(userStore.firebaseToken.validate());
        }).catchError(onError);
    }
    return res;
  }

  static Future<TimezoneResponse> getCountryWiseTimezoneApi({required String phoneCode, required String isoCode}) async {
    TimezoneResponse res = TimezoneResponse.fromJson(await handleResponse(await buildHttpResponse(AuthApiEndpoints.timezone + "?phone_code=$phoneCode&iso2=$isoCode", method: HttpMethod.GET)));

    signupStore.setTimezoneList(res.zone);

    return res;
  }

  static Future<LoginResponse> forgotPasswordApi({required Map<String, dynamic> request}) async {
    LoginResponse res = LoginResponse.fromJson(await handleResponse(await buildHttpResponse(AuthApiEndpoints.forgotPasswordUrl, request: request, method: HttpMethod.POST)));
    return res;
  }

  static Future<LoginResponse> resetPasswordApi({required Map<String, dynamic> request}) async {
    LoginResponse res = LoginResponse.fromJson(await handleResponse(await buildHttpResponse(AuthApiEndpoints.resetPasswordUrl, request: request, method: HttpMethod.POST)));
    return res;
  }

  static Future<LoginResponse> changePasswordApi({required Map<String, dynamic> request}) async {
    LoginResponse res = LoginResponse.fromJson(await handleResponse(await buildHttpResponse(AuthApiEndpoints.changePasswordUrl, request: request, method: HttpMethod.POST)));
    return res;
  }

  static Future<LoginResponse> onSignUpApi({required Map<String, dynamic> request}) async {
    LoginResponse res = LoginResponse.fromJson(await handleResponse(await buildHttpResponse(AuthApiEndpoints.signUpUrl, request: request, method: HttpMethod.POST)));
    return res;
  }

  static Future<OtpSuccessResponse> onVerifyOtp({required Map<String, dynamic> request}) async {
    OtpSuccessResponse res = OtpSuccessResponse.fromJson(await handleResponse(await buildHttpResponse(AuthApiEndpoints.verifyOtp, request: request, method: HttpMethod.POST)));
    return res;
  }

  static Future<OtpSuccessResponse> onDeleteAccount({required Map<String, dynamic> request}) async {
    OtpSuccessResponse res = OtpSuccessResponse.fromJson(await handleResponse(await buildHttpResponse(AuthApiEndpoints.deleteAccount, request: request, method: HttpMethod.POST)));
    return res;
  }

  static Future<OtpSuccessResponse> onSendEmailOtp({required Map<String, dynamic> request}) async {
    OtpSuccessResponse res = OtpSuccessResponse.fromJson(await handleResponse(await buildHttpResponse(AuthApiEndpoints.sendEmailOtp, request: request, method: HttpMethod.POST)));
    return res;
  }

  static Future<ProfileCompletionResponse> getProfileCompletionApi() async {
    ProfileCompletionResponse res = ProfileCompletionResponse.fromJson(
      await handleResponse(
        await buildHttpResponse(AuthApiEndpoints.getProfileStatus + "/${userStore.userId}", method: HttpMethod.GET),
      ),
    );

    authStore.setProfileCompletionData(res.toJson());

    return res;
  }
}
