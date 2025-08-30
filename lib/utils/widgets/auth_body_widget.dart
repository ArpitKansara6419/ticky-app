import 'package:ag_widgets/extension/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/utils/imports.dart';

class AuthBodyWidget extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final Widget child;
  final Widget? headerChild;
  final bool? needBackButton;

  const AuthBodyWidget({Key? key, this.title, this.subTitle, required this.child, this.headerChild, this.needBackButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedScrollView(
      listAnimationType: ListAnimationType.None,
      padding: EdgeInsets.all(16),
      children: [
        AppImages.appLogoVertical.agLoadImage(height: 140, width: 140, fit: BoxFit.contain),
        Text(title ?? 'Hi, Welcome Back👋', style: primaryTextStyle(size: 28)),
        8.height,
        Text(subTitle ?? 'Sign in to your account', style: secondaryTextStyle(size: 14)),
        26.height,
        Container(
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(color: Colors.white, borderRadius: radius()),
          child: child,
        )
      ],
    );
  }
}
