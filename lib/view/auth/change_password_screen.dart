import 'package:ag_widgets/extension/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/utils/widgets/app_scaffold_with_loader.dart';
import 'package:ticky/utils/widgets/auth_body_widget.dart';
import 'package:ticky/utils/widgets/title_form_component.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  GlobalKey<FormState> changePasswordState = GlobalKey();

  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();

  FocusNode oldPasswordFocus = FocusNode();
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
    return Scaffold(
      appBar: AppBar(),
      body: Observer(
        builder: (context) {
          return AppScaffoldWithLoader(
            isLoading: appLoaderStore.appLoadingState[AppLoaderStateName.changePasswordApiState].validate(),
            child: AuthBodyWidget(
              title: "Change Your Password 🔒",
              subTitle: "Update your password to keep your account secure",
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: changePasswordState,
                child: AnimatedScrollView(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  padding: EdgeInsets.all(16),
                  children: [
                    TitleFormComponent(
                      text: 'Old Password',
                      child: AppTextField(
                        textFieldType: TextFieldType.PASSWORD,
                        obscureText: true,
                        focus: oldPasswordFocus,
                        nextFocus: newPasswordFocus,
                        controller: oldPassword,
                        suffixPasswordVisibleWidget: AppSvgIcons.icPasswordShow.agLoadImage(height: 10, width: 10).paddingAll(14),
                        suffixPasswordInvisibleWidget: AppSvgIcons.icPasswordHide.agLoadImage(height: 10, width: 10).paddingAll(14),
                        decoration: inputDecoration(svgImage: AppSvgIcons.icPassword),
                      ),
                    ),
                    16.height,
                    TitleFormComponent(
                      text: 'New Password',
                      child: AppTextField(
                        textFieldType: TextFieldType.PASSWORD,
                        obscureText: true,
                        focus: newPasswordFocus,
                        nextFocus: confirmNewPasswordFocus,
                        controller: newPassword,
                        validator: (v) {
                          if (v.validate().isEmpty) {
                            return errorThisFieldRequired;
                          } else if (v == oldPassword.text) {
                            return "New password cannot be the same as old password";
                          }
                          return null;
                        },
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
                          if (v.validate().isEmpty) {
                            return errorThisFieldRequired;
                          } else if (newPassword.text != v) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                        onFieldSubmitted: (s) {
                          _handleOnChangePasswordClick();
                        },
                        suffixPasswordVisibleWidget: AppSvgIcons.icPasswordShow.agLoadImage(height: 10, width: 10).paddingAll(14),
                        suffixPasswordInvisibleWidget: AppSvgIcons.icPasswordHide.agLoadImage(height: 10, width: 10).paddingAll(14),
                        decoration: inputDecoration(svgImage: AppSvgIcons.icPassword),
                      ),
                    ),
                    32.height,
                    AppButton(
                      width: context.width(),
                      text: "Update Password",
                      onTap: _handleOnChangePasswordClick,
                    ),
                    32.height,
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _handleOnChangePasswordClick() async {
    if (changePasswordState.currentState!.validate()) {
      changePasswordState.currentState!.save();

      Map<String, dynamic> request = {
        "email": userStore.email.validate(),
        "current_password": oldPassword.text.trim().validate(),
        "password": newPassword.text.trim().validate(),
        "confirm_password": confirmNewPassword.text.trim().validate(),
      };

      await signupStore.onChangePassword(request: request);
    }
  }
}
