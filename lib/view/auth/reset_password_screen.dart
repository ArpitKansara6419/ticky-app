import 'package:ag_widgets/extension/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/auth/user_data.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/utils/widgets/app_scaffold_with_loader.dart';
import 'package:ticky/utils/widgets/auth_body_widget.dart';
import 'package:ticky/utils/widgets/title_form_component.dart';

class ResetPasswordScreen extends StatefulWidget {
  final User data;

  const ResetPasswordScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  GlobalKey<FormState> resetPasswordState = GlobalKey();

  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();

  FocusNode newPasswordFocus = FocusNode();
  FocusNode confirmNewPasswordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Observer(
          builder: (context) {
            return AppScaffoldWithLoader(
              isLoading: appLoaderStore.appLoadingState[AppLoaderStateName.resetPasswordApiState].validate(),
              child: AuthBodyWidget(
                title: "Reset Your Password 🔒",
                subTitle: "Please enter a new password to continue.",
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: resetPasswordState,
                  child: AnimatedScrollView(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    padding: EdgeInsets.all(16),
                    children: [
                      TitleFormComponent(
                        text: 'New Password',
                        child: AppTextField(
                          textFieldType: TextFieldType.PASSWORD,
                          obscureText: true,
                          focus: newPasswordFocus,
                          nextFocus: confirmNewPasswordFocus,
                          controller: newPassword,
                          suffixPasswordVisibleWidget: AppSvgIcons.icPasswordShow.agLoadImage(height: 10, width: 10).paddingAll(14),
                          suffixPasswordInvisibleWidget: AppSvgIcons.icPasswordHide.agLoadImage(height: 10, width: 10).paddingAll(14),
                          decoration: inputDecoration(svgImage: AppSvgIcons.icPassword),
                        ),
                      ),
                      16.height,
                      TitleFormComponent(
                        text: 'Confirm New Password',
                        child: AppTextField(
                          textFieldType: TextFieldType.PASSWORD,
                          obscureText: true,
                          focus: confirmNewPasswordFocus,
                          controller: confirmNewPassword,
                          validator: (v) {
                            if (newPassword.text != v) {
                              return "Password does not match";
                            } else if (confirmNewPassword.text.isEmpty) {
                              return errorThisFieldRequired;
                            }
                            return null;
                          },
                          onFieldSubmitted: (s) {
                            // changePassword();
                          },
                          suffixPasswordVisibleWidget: AppSvgIcons.icPasswordShow.agLoadImage(height: 10, width: 10).paddingAll(14),
                          suffixPasswordInvisibleWidget: AppSvgIcons.icPasswordHide.agLoadImage(height: 10, width: 10).paddingAll(14),
                          decoration: inputDecoration(svgImage: AppSvgIcons.icPassword),
                        ),
                      ),
                      32.height,
                      AppButton(
                        width: context.width(),
                        text: "Reset Password",
                        onTap: () async {
                          if (resetPasswordState.currentState!.validate()) {
                            resetPasswordState.currentState!.save();

                            Map<String, dynamic> request = {
                              "email": widget.data.email.validate(),
                              "password": newPassword.text.trim().validate(),
                              "password_confirmation": confirmNewPassword.text.trim().validate(),
                            };

                            await signupStore.onResetPassword(request: request);
                          }
                        },
                      ),
                      32.height,
                    ],
                  ),
                ),
              ),
            );
          },
        ).paddingTop(context.statusBarHeight + 16),
      ),
    );
  }
}
