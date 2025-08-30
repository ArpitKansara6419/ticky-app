import 'package:ag_widgets/ag_widgets.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/utils/widgets/app_scaffold_with_loader.dart';
import 'package:ticky/utils/widgets/auth_body_widget.dart';
import 'package:ticky/utils/widgets/loader/animation/shake_text.dart';
import 'package:ticky/utils/widgets/title_form_component.dart';
import 'package:ticky/view/auth/forgot_password_screen.dart';
import 'package:ticky/view/auth/sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController controller = TextEditingController(text: Config.baseUrl);
  String? token;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    token = await _fcm.getToken();

    if (getStringAsync("base_url").validate().isNotEmpty) {
      controller = TextEditingController(text: getStringAsync("base_url").validate());
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    authStore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*   appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: context.scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
      ),*/
      body: SafeArea(
        child: Observer(builder: (context) {
          return AppScaffoldWithLoader(
            isLoading: appLoaderStore.appLoadingState[AppLoaderStateName.loginApiState].validate(),
            child: AuthBodyWidget(
              title: "Hi, Welcome Back👋",
              subTitle: "Sign in to your account ",
              child: Form(
                key: authStore.signInFormState,
                child: AnimatedScrollView(
                  padding: EdgeInsets.all(16),
                  children: [
                    TitleFormComponent(
                      text: 'Email',
                      child: AppTextField(
                        textFieldType: TextFieldType.EMAIL_ENHANCED,
                        controller: authStore.emailCont,
                        focus: authStore.emailFocusNode,
                        nextFocus: authStore.passwordFocusNode,
                        decoration: inputDecoration(svgImage: AppSvgIcons.icEmail, hint: "Enter Email"),
                      ),
                    ),
                    16.height,
                    TitleFormComponent(
                      text: 'Password',
                      child: AppTextField(
                        textFieldType: TextFieldType.PASSWORD,
                        controller: authStore.passCont,
                        focus: authStore.passwordFocusNode,
                        suffixPasswordVisibleWidget: AppSvgIcons.icPasswordShow.agLoadImage(height: 10, width: 10).paddingAll(14),
                        suffixPasswordInvisibleWidget: AppSvgIcons.icPasswordHide.agLoadImage(height: 10, width: 10).paddingAll(14),
                        decoration: inputDecoration(svgImage: AppSvgIcons.icPassword, hint: "Enter Password"),
                      ),
                    ),
                    Observer(
                      builder: (context) {
                        if (authStore.inValidCredentials.validate().isNotEmpty) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              8.height,
                              ShakeText(text: authStore.inValidCredentials.validate()).paddingLeft(8),
                            ],
                          );
                        } else {
                          return Offstage();
                        }
                      },
                    ),
                    16.height,
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            authStore.setRememberValue(!authStore.isRemember);
                          },
                          child: Row(
                            children: [
                              Observer(
                                builder: (context) {
                                  return Container(
                                    padding: EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                      borderRadius: radius(4),
                                      border: authStore.isRemember ? Border.all(color: Colors.transparent) : Border.all(color: Colors.grey.shade200),
                                      color: authStore.isRemember ? context.primaryColor : null,
                                    ),
                                    child: Icon(Icons.done, size: 12, color: Colors.white),
                                  );
                                },
                              ),
                              4.width,
                              Text(
                                "Remember Me",
                                style: primaryTextStyle(color: primaryColor, size: 12),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            authStore.setInValidCredentialsValue(null);
                            ForgotPasswordScreen().launch(context);
                          },
                          child: Text(
                            "Forgot Password?",
                            style: primaryTextStyle(color: primaryColor, size: 12),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                    26.height,
                    AppButton(
                      width: context.width(),
                      text: "LOGIN",
                      textStyle: boldTextStyle(letterSpacing: 1.4, color: Colors.white),
                      onTap: () => authStore.onSignSubmit(token: token, context: context),
                    ),
                    30.height,
                    RichTextWidget(
                      list: [
                        TextSpan(text: "Don't have an account?", style: secondaryTextStyle(size: 14)),
                        TextSpan(
                          text: " Register",
                          style: boldTextStyle(color: context.primaryColor, size: 14, fontStyle: FontStyle.italic),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              authStore.setInValidCredentialsValue(null);
                              SignUpScreen().launch(context);
                            },
                        ),
                      ],
                    ).center(),
                    32.height,
                    /*  Divider(),
                    8.height,
                    Text('Current URL: ${getStringAsync("base_url").validate()}', style: primaryTextStyle(size: 12)),
                    8.height,
                    TitleFormComponent(
                      text: 'BaseURL',
                      child: AppTextField(
                        textFieldType: TextFieldType.NAME,
                        controller: controller,
                        suffixPasswordVisibleWidget: AppSvgIcons.icPasswordShow.agLoadImage(height: 10, width: 10).paddingAll(14),
                        suffixPasswordInvisibleWidget: AppSvgIcons.icPasswordHide.agLoadImage(height: 10, width: 10).paddingAll(14),
                        decoration: inputDecoration(
                          svgImage: AppSvgIcons.icPassword,
                        ),
                      ),
                    ),
                    16.height,
                    AppButton(
                      width: context.width(),
                      text: "Save Base URL",
                      textStyle: boldTextStyle(letterSpacing: 1.4, color: Colors.white),
                      onTap: () {
                        hideKeyboard(context);
                        setValue("base_url", controller.text.validate().trim());
                        setState(() {});
                      },
                    ),*/
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
