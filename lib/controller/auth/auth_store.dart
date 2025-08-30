import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/auth/auth_api_controller.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/auth/profile_completion_response.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/view/auth/otp_verification_screen.dart';
import 'package:ticky/view/dashboard/dashboard_view.dart';

part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  @observable
  TextEditingController emailCont = TextEditingController();

  @observable
  TextEditingController passCont = TextEditingController();

  @observable
  bool isRemember = true;

  @observable
  String? fcmToken = '';

  @observable
  String? inValidCredentials;

  @observable
  ProfileCompletionResponse? profileCompletionData;

  @observable
  FocusNode emailFocusNode = FocusNode();

  @observable
  FocusNode passwordFocusNode = FocusNode();

  @action
  Future<void> setRememberValue(bool val, {bool isInitializing = false}) async {
    isRemember = val;
    if (!isInitializing) await setValue(SharePreferencesKey.isRemember, val);
  }

  @action
  Future<void> setInValidCredentialsValue(String? val) async {
    inValidCredentials = val;
  }

  @action
  Future<void> setProfileCompletionData(Map<String, dynamic> val, {bool isInitializing = false}) async {
    profileCompletionData = ProfileCompletionResponse.fromJson(val);
  }

  @observable
  GlobalKey<FormState> signInFormState = GlobalKey();

  @action
  Future<void> onSignSubmit({
    required String? token,
    required BuildContext context,
  }) async {
    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.loginApiState, value: false);
    if (signInFormState.currentState!.validate()) {
      signInFormState.currentState!.save();

      setInValidCredentialsValue(null);
      hideKeyboard(context);

      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.loginApiState, value: true);

      Map<String, dynamic> request = {
        "email": emailCont.text,
        "password": passCont.text,
        "device_token": token != null && token.isNotEmpty ? token : getStringAsync(SharePreferencesKey.firebaseToken),
      };

      await AuthApiController.loginApi(request: request).then((value) async {
        if (value.user!.emailVerification.validate() == 0) {
          // toast("Email Not Verified!!");
          OtpVerificationScreen(loginResponse: value, isFromLogin: true).launch(context);
          appLoaderStore.setLoaderValue(appState: AppLoaderStateName.loginApiState, value: false);
          return;
        }

        if (authStore.isRemember) {
          userStore.setLoggedIn(true);
        }
        userStore.setUserId(value.user!.id.validate());

        signupStore.saveUserDataToPreference(loginData: value, isLoginSave: true);

        appLoaderStore.setLoaderValue(appState: AppLoaderStateName.loginApiState, value: false);
        toast("Login Successfully!!!");

        DashboardView().launch(getContext, isNewTask: true);
      }).catchError((e) {
        setInValidCredentialsValue(e);
        appLoaderStore.setLoaderValue(appState: AppLoaderStateName.loginApiState, value: false);
      });
    }
  }

  @action
  Future<void> dispose() async {
    // Enter the dispose methods
    emailCont.clear();
    passCont.clear();
    setInValidCredentialsValue(null);
    signInFormState = GlobalKey();
  }
}
