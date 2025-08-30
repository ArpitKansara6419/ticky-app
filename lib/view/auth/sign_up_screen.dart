import 'package:ag_widgets/ag_widgets.dart';
import 'package:ag_widgets/extension/list_extensions.dart';
import 'package:country_code_picker_plus/country_code_picker_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/utils/widgets/app_loader.dart';
import 'package:ticky/utils/widgets/app_scaffold_with_loader.dart';
import 'package:ticky/utils/widgets/auth_body_widget.dart';
import 'package:ticky/utils/widgets/form_component_device_based.dart';
import 'package:ticky/utils/widgets/loader/animation/shake_text.dart';
import 'package:ticky/utils/widgets/phone_number_widget.dart';
import 'package:ticky/utils/widgets/title_form_component.dart';
import 'package:ticky/view/auth/timezone_dropdown.dart';

import '../../controller/auth/auth_api_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? contactISO;
  String? countryCode;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    contactISO = getStringAsync(SharePreferencesKey.contactISO);
    countryCode = getStringAsync(SharePreferencesKey.countryCode);
  }

  void getTimezone() {
    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.timezoneApiState, value: true);

    AuthApiController.getCountryWiseTimezoneApi(
      phoneCode: countryCode.validate(),
      isoCode: contactISO.validate(),
    ).then((value) {
      signupStore.setTimezoneList(value.zone);

      if (value.zone!.timezones.validate().isSingle) {
        signupStore.setTimezone(value.zone!.timezones!.first);
      }

      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.timezoneApiState, value: false);
    }).catchError((e) {
      toast(e.toString());
      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.timezoneApiState, value: false);
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    signupStore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: signupStore.signUpFormState,
        child: Observer(builder: (context) {
          return AppScaffoldWithLoader(
            isLoading: appLoaderStore.appLoadingState[AppLoaderStateName.signUpApiState].validate(),
            child: AuthBodyWidget(
              title: "Join Us Today 🎉",
              subTitle: "Create an account to get started!",
              child: AnimatedScrollView(
                listAnimationType: ListAnimationType.None,
                padding: EdgeInsets.all(16),
                children: [
                  FormComponentDeviceBased(
                    child1: TitleFormComponent(
                      text: "First Name*",
                      child: AppTextField(
                        textFieldType: TextFieldType.NAME,
                        controller: signupStore.firstNameCont,
                        focus: signupStore.firstNameFocusNode,
                        nextFocus: signupStore.lastNameFocusNode,
                        decoration: inputDecoration(svgImage: AppSvgIcons.icEmail, hint: "Enter First Name"),
                      ),
                    ),
                    child2: TitleFormComponent(
                      text: "Last Name*",
                      child: AppTextField(
                        textFieldType: TextFieldType.NAME,
                        controller: signupStore.lastNameCont,
                        focus: signupStore.lastNameFocusNode,
                        nextFocus: signupStore.emailFocusNode,
                        decoration: inputDecoration(svgImage: AppSvgIcons.icEmail, hint: "Enter Last Name"),
                      ),
                    ),
                  ),
                  16.height,
                  TitleFormComponent(
                    text: "Mobile Number*",
                    child: Observer(builder: (context) {
                      return PhoneNumberWidget(
                        initialCountryCode: contactISO,
                        controller: signupStore.mobileCont,
                        focusNode: signupStore.mobileNumberFocusNode,
                        nextFocus: signupStore.passwordFocusNode,
                        hint: "Enter Mobile Number",
                        validator: (s) {
                          if (s!.trim().isEmpty) {
                            return errorThisFieldRequired.validate(value: errorThisFieldRequired);
                          }
                          return null;
                        },
                        onInit: (country) async {
                          if (country != null) {
                            countryCode = country.dialCode;
                            contactISO = country.code;
                            await setValue(SharePreferencesKey.countryCode, countryCode);
                            await setValue(SharePreferencesKey.contactISO, contactISO);
                            getTimezone();
                          }
                        },
                        onCountrySelected: (Country country) async {
                          countryCode = country.dialCode;
                          contactISO = country.code;
                          setValue(SharePreferencesKey.countryCode, countryCode);
                          setValue(SharePreferencesKey.contactISO, contactISO);
                          getTimezone();
                          setState(() {});
                        },
                      );
                    }),
                  ),
                  16.height,
                  Observer(builder: (context) {
                    return TitleFormComponent(
                      text: "Timezone*",
                      child: Row(
                        children: [
                          if (signupStore.currentTimeZone != null)
                            TimezoneDropdown(
                              timezones: signupStore.currentTimeZone!.timezones.validate(),
                              initialValue: signupStore.selectedTimeZone,
                              onChanged: (p0) {
                                signupStore.setTimezone(p0);
                              },
                            ).expand()
                          else ...[
                            4.height,
                            Text(
                              "Loading Timezone...",
                              style: secondaryTextStyle(size: 12),
                            ),
                            4.height,
                          ],
                          if (appLoaderStore.appLoadingState[AppLoaderStateName.timezoneApiState].validate()) ...[
                            16.width,
                            aimLoader(context, size: 20),
                          ]
                        ],
                      ),
                    );
                  }),
                  16.height,
                  TitleFormComponent(
                    text: "Email*",
                    child: AppTextField(
                      textFieldType: TextFieldType.EMAIL_ENHANCED,
                      controller: signupStore.emailCont,
                      focus: signupStore.emailFocusNode,
                      nextFocus: signupStore.mobileNumberFocusNode,
                      decoration: inputDecoration(svgImage: AppSvgIcons.icEmail, hint: "Enter Email"),
                    ),
                  ),
                  Observer(
                    builder: (context) {
                      if (signupStore.emailError.validate().isNotEmpty) {
                        return ShakeText(text: signupStore.emailError.validate()).paddingLeft(8);
                      } else {
                        return Offstage();
                      }
                    },
                  ),
                  16.height,
                  TitleFormComponent(
                    text: "Password*",
                    child: AppTextField(
                      textFieldType: TextFieldType.PASSWORD,
                      obscureText: true,
                      controller: signupStore.passCont,
                      focus: signupStore.passwordFocusNode,
                      suffixPasswordVisibleWidget: AppSvgIcons.icPasswordShow.agLoadImage(height: 10, width: 10).paddingAll(14),
                      suffixPasswordInvisibleWidget: AppSvgIcons.icPasswordHide.agLoadImage(height: 10, width: 10).paddingAll(14),
                      decoration: inputDecoration(svgImage: AppSvgIcons.icPassword, hint: "Enter Password"),
                    ),
                  ),
                  Observer(
                    builder: (context) {
                      if (signupStore.phoneNumberError.validate().isNotEmpty) {
                        return ShakeText(text: signupStore.phoneNumberError.validate()).paddingLeft(8);
                      } else {
                        return Offstage();
                      }
                    },
                  ),

                  /* 16.height,
                  TitleFormComponent(
                    text: "Referral Code",
                    child: AppTextField(
                      textFieldType: TextFieldType.OTHER,
                      controller: signupStore.referralCont,
                      focus: signupStore.referralFocusNode,
                      suffixPasswordVisibleWidget: AppSvgIcons.icPasswordShow.agLoadImage(height: 10, width: 10).paddingAll(14),
                      suffixPasswordInvisibleWidget: AppSvgIcons.icPasswordHide.agLoadImage(height: 10, width: 10).paddingAll(14),
                      decoration: inputDecoration(svgImage: AppSvgIcons.icPassword),
                    ),
                  ),*/
                  26.height,
                  AppButton(
                    width: context.width(),
                    text: "Join Now",
                    textStyle: boldTextStyle(letterSpacing: 1.4, color: Colors.white),
                    onTap: signupStore.onSignUpSubmit,
                  ),
                  26.height,
                  RichTextWidget(
                    list: [
                      TextSpan(text: "Have an account?", style: secondaryTextStyle(size: 14)),
                      TextSpan(
                        text: " Sign In",
                        style: boldTextStyle(color: context.primaryColor, size: 14, fontStyle: FontStyle.italic),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            signupStore.setPhoneNumberErrorValue(null);
                            signupStore.setEmailErrorValue(null);
                            finish(context);
                          },
                      ),
                    ],
                  ).center(),
                ],
              ),
            ),
          );
        }),
      ).paddingTop(context.statusBarHeight + 16),
    );
  }
}
