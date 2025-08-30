import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/utils/imports.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: [
        buildLeadingWidget(context, image: AppSvgIcons.icNoInternet),
        Text(
          "No internet",
          style: secondaryTextStyle(
            weight: FontWeight.w600,
            color: black,
          ),
        )
      ],
    );
  }
}
