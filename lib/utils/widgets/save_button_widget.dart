import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/utils/widgets/app_loader.dart';

class SaveButtonWidget extends StatelessWidget {
  final String? buttonName;
  final List<Widget> children;
  final bool loader;
  final Function()? onSubmit;

  const SaveButtonWidget({
    Key? key,
    required this.children,
    required this.onSubmit,
    this.buttonName,
    this.loader = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        AnimatedScrollView(
          crossAxisAlignment: CrossAxisAlignment.start,
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 80 + (MediaQuery.of(context).viewInsets.bottom),
            top: 16,
          ),
          listAnimationType: ListAnimationType.None,
          children: children,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
            color: context.scaffoldBackgroundColor,
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 16 + (Platform.isIOS ? 12 : 0)),
            child: ButtonAppLoader(
              isLoading: loader,
              child: AppButton(
                disabledColor: context.primaryColor.withOpacity(0.5),
                text: buttonName ?? "Save",
                textStyle: boldTextStyle(letterSpacing: 1.4, color: Colors.white),
                onTap: onSubmit,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
