import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/utils/widgets/auth_body_widget.dart';
import 'package:ticky/utils/widgets/title_form_component.dart';

import '../../utils/widgets/app_scaffold_with_loader.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(builder: (context) {
        return AppScaffoldWithLoader(
          isLoading: appLoaderStore.appLoadingState[AppLoaderStateName.forgotPasswordApiState].validate(),
          child: AuthBodyWidget(
            title: "Forgot Your Password? 😟",
            subTitle: "Enter your registered email address, and we’ll send you an OTP to reset your password.",
            child: AnimatedScrollView(
              padding: EdgeInsets.all(16),
              children: [
                TitleFormComponent(
                  text: 'Email',
                  child: AppTextField(
                    textFieldType: TextFieldType.EMAIL_ENHANCED,
                    controller: signupStore.emailCont,
                    decoration: inputDecoration(
                      hint: "Enter your email address",
                      svgImage: AppSvgIcons.icEmail,
                    ),
                  ),
                ),
                8.height,
                Text('* We’ll send a 6-digit OTP to your email.', style: secondaryTextStyle(size: 12)),
                32.height,
                AppButton(
                  width: context.width(),
                  text: "Send OTP",
                  textStyle: boldTextStyle(letterSpacing: 1.4, color: Colors.white),
                  onTap: signupStore.onForgotPassword,
                ),
                16.height,
              ],
            ),
          ).paddingTop(context.statusBarHeight + 16),
        );
      }),
    );
  }
}
