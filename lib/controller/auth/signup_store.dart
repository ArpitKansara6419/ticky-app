import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/auth/auth_api_controller.dart';
import 'package:ticky/controller/engineer/master_data_controller/master_data_controller.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/auth/login_response.dart';
import 'package:ticky/model/auth/timezone_response.dart';
import 'package:ticky/model/auth/user_data.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/view/auth/otp_verification_screen.dart';
import 'package:ticky/view/auth/reset_password_screen.dart';
import 'package:ticky/view/auth/sign_in_screen.dart';
import 'package:ticky/view/dashboard/dashboard_view.dart';

part 'signup_store.g.dart';

class SignupStore = SignupStoreBase with _$SignupStore;

abstract class SignupStoreBase with Store {
  @observable
  TextEditingController firstNameCont = TextEditingController();

  @observable
  TextEditingController lastNameCont = TextEditingController();

  @observable
  TextEditingController emailCont = TextEditingController();

  @observable
  TextEditingController mobileCont = TextEditingController();

  @observable
  String countryCode = "";
  @observable
  String contactIso = "";

  @observable
  TextEditingController passCont = TextEditingController();

  @observable
  TextEditingController referralCont = TextEditingController();

  @observable
  String? otpCode;
  @observable
  String? emailError;
  @observable
  String? phoneNumberError;

  @observable
  FocusNode firstNameFocusNode = FocusNode();

  @observable
  FocusNode lastNameFocusNode = FocusNode();

  @observable
  FocusNode emailFocusNode = FocusNode();

  @observable
  FocusNode mobileNumberFocusNode = FocusNode();

  @observable
  FocusNode passwordFocusNode = FocusNode();

  @observable
  FocusNode referralFocusNode = FocusNode();

  @observable
  Timezone? currentTimeZone;

  @observable
  Timezones? selectedTimeZone;

  @action
  Future<void> setEmailErrorValue(String? val) async {
    emailError = val;
  }

  @action
  Future<void> setTimezoneList(Timezone? val) async {
    currentTimeZone = val;
  }

  @action
  Future<void> setTimezone(Timezones? val) async {
    selectedTimeZone = val;
  }

  @action
  Future<void> setPhoneNumberErrorValue(String? val) async {
    phoneNumberError = val;
  }

  @observable
  GlobalKey<FormState> signUpFormState = GlobalKey();

  Future<void> saveUserDataToPreference({bool isLoginSave = false, required LoginResponse loginData}) async {
    if (isLoginSave) {
      userStore.setLoggedIn(true);
      userStore.setAccessToken(loginData.token.validate());
    }

    User userData = loginData.user != null ? loginData.user! : loginData.userData!;

    userStore.lastUpdatedUserValue = loginData;

    userStore.setUserId(userData.id.validate());
    userStore.setFirstName(userData.firstName.validate());
    userStore.setLastName(userData.lastName.validate());
    userStore.setEmail(userData.email.validate());
    userStore.setPhoneNumber(userData.contact.validate());
    userStore.setCountryCodeNumber(userData.countryCode.validate());
    if (userData.profileImage.validate().isNotEmpty) {
      userStore.setProfileImage(Config.imageUrl + userData.profileImage.validate());
    } else {
      userStore.setProfileImage("");
    }
    userStore.setPhoneNumberVerified(userData.phoneVerification.getBoolInt());
    userStore.setEmailVerified(userData.emailVerification.getBoolInt());
    userStore.setGdprConsentVerified(userData.gdprConsent.validate());

    if (userData.payRates != null) {
      userStore.setJobType(userData.jobType.validate());
      userStore.setJobTitle(userData.jobTitle.validate());
      userStore.setCheckInTime(userData.payRates!.checkInTime.validate());
      userStore.setCheckOutTime(userData.payRates!.checkOutTime.validate());
      userStore.setCurrencyCodeVerified(userData.payRates!.currencyType.validate().getCurrencyType().validate());
    } else {
      userStore.setCurrencyCodeVerified("zł");
    }

    if (isLoginSave) {
      AuthApiController.getProfileCompletionApi();
    }
  }

  @action
  Future<void> onSignUpSubmit() async {
    if (signUpFormState.currentState!.validate()) {
      signUpFormState.currentState!.save();

      hideKeyboard(getContext);

      countryCode = getStringAsync(SharePreferencesKey.countryCode);
      contactIso = getStringAsync(SharePreferencesKey.contactISO);

      Map<String, dynamic> request = {
        "first_name": firstNameCont.text.trim(),
        "last_name": lastNameCont.text.trim(),
        "email": emailCont.text.trim(),
        "contact": mobileCont.text.trim().replaceAll("+", ""),
        "country_code": countryCode.trim().replaceAll("+", ""),
        "contact_iso": contactIso.trim(),
        "password": passCont.text.trim(),
        "test_otp_email": "",
        "referral_code": referralCont.text.trim(),
        "user": "engineer",
        "device_token": getStringAsync(SharePreferencesKey.firebaseToken),
      };

      if (selectedTimeZone != null) {
        request.putIfAbsent("timezone", () => selectedTimeZone?.zoneName.validate());
      }

      setEmailErrorValue(null);
      setPhoneNumberErrorValue(null);

      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.signUpApiState, value: true);

      await AuthApiController.onSignUpApi(request: request).then((loginData) {
        toast("OTP sent to your email Successfully");

        userStore.setEmailVerified(false);
        userStore.setPhoneNumberVerified(false);

        OtpVerificationScreen(loginResponse: loginData).launch(getContext, isNewTask: true);

        appLoaderStore.setLoaderValue(appState: AppLoaderStateName.signUpApiState, value: false);
      }).catchError((e) {
        appLoaderStore.setLoaderValue(appState: AppLoaderStateName.signUpApiState, value: false);
        // toast(e.toString(), print: true);

        if (e.toString().contains("email")) {
          setEmailErrorValue(e.toString());
        } else if (e.toString().contains("contact")) {
          setPhoneNumberErrorValue(e.toString());
        } else {
          toast(e.toString());
        }
      });

      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.signUpApiState, value: false);
    }
  }

  @action
  Future<void> verifyOtp({required LoginResponse loginData, required String otp, bool? isForgotPassword}) async {
    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.loginApiState, value: true);

    hideKeyboard(getContext);
    User currentUser = loginData.user!;

    Map<String, dynamic> request = {
      "email": currentUser.email,
      "otp": otp,
    };

    await AuthApiController.onVerifyOtp(request: request).then((res) async {
      if (res.status.validate()) {
        toast(res.message.validate());

        if (isForgotPassword.validate()) {
          ResetPasswordScreen(data: currentUser).launch(getContext, isNewTask: true);
          appLoaderStore.setLoaderValue(appState: AppLoaderStateName.loginApiState, value: false);
          return;
        } else {
          userStore.setAccessToken(loginData.token.validate());
          saveUserDataToPreference(isLoginSave: true, loginData: loginData);
          await AuthApiController.updateTokenApi(token: userStore.firebaseToken.validate()).then((value) {}).catchError(onError);
          await MasterDataController.fetchAllData(isSaveDetail: false);
          DashboardView().launch(getContext);
        }
      } else {
        toast(res.message.validate());
      }
      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.loginApiState, value: false);
    }).catchError((e) {
      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.loginApiState, value: false);
      toast(e.toString(), print: true);
    });
  }

  @action
  Future<void> sendEmailOtp({required String email}) async {
    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.loginApiState, value: true);
    hideKeyboard(getContext);

    Map<String, dynamic> request = {
      "email": email,
      "test_otp_email": "",
    };

    await AuthApiController.onSendEmailOtp(request: request).then((res) {
      toast(res.message.validate());
      otpCode = res.otp.validate().toString();
      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.loginApiState, value: false);
    }).catchError((e) {
      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.loginApiState, value: false);
      toast(e.toString(), print: true);
    });
  }

  @action
  Future<void> onForgotPassword() async {
    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.forgotPasswordApiState, value: true);

    hideKeyboard(getContext);
    Map<String, dynamic> request = {"email": emailCont.text};

    await AuthApiController.forgotPasswordApi(request: request).then((value) {
      toast("OTP sent to your email Successfully");

      value.user = User(email: emailCont.text.trim());

      OtpVerificationScreen(loginResponse: value, isForgotPassword: true).launch(getContext, isNewTask: true);

      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.forgotPasswordApiState, value: true);
    }).catchError((e) {
      toast(e);
      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.forgotPasswordApiState, value: false);
    });
  }

  @action
  Future<void> onResetPassword({required Map<String, dynamic> request}) async {
    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.resetPasswordApiState, value: true);
    hideKeyboard(getContext);

    await AuthApiController.resetPasswordApi(request: request).then((value) {
      toast(value.message.validate());

      SignInScreen().launch(getContext, isNewTask: true);

      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.resetPasswordApiState, value: true);
    }).catchError((e) {
      toast(e);
      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.resetPasswordApiState, value: false);
    });
  }

  @action
  Future<void> onChangePassword({required Map<String, dynamic> request}) async {
    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.changePasswordApiState, value: true);
    hideKeyboard(getContext);

    await AuthApiController.changePasswordApi(request: request).then((value) {
      toast(value.message.validate());

      finish(getContext);

      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.changePasswordApiState, value: false);
    }).catchError((e) {
      toast(e);
      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.changePasswordApiState, value: false);
    });
  }

  @action
  Future<void> onDeleteAccount({required Map<String, dynamic> request}) async {
    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.deleteAccountApiState, value: true);
    hideKeyboard(getContext);

    await AuthApiController.onDeleteAccount(request: request).then((value) {
      toast(value.message.validate());

      SignInScreen().launch(getContext, pageRouteAnimation: Platform.isIOS ? null : PageRouteAnimation.Slide, isNewTask: true);

      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.deleteAccountApiState, value: true);
    }).catchError((e) {
      toast(e);
      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.deleteAccountApiState, value: false);
    });
  }

  @action
  void setOtpValue(String value) {
    otpCode = value;
  }

  @action
  Future<void> dispose() async {
    firstNameCont.clear();
    lastNameCont.clear();
    emailCont.clear();
    mobileCont.clear();
    passCont.clear();
    referralCont.clear();
    countryCode = "+91";
    // Enter the dispose methods
  }
}
