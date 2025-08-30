import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class IconTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final TextStyle? textStyle;
  final double spacing;
  final Color? iconColor;
  final double? iconSize;

  const IconTextWidget({
    Key? key,
    required this.icon,
    required this.text,
    this.textStyle,
    this.spacing = 8.0,
    this.iconColor,
    this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: iconColor ?? context.iconColor,
          size: iconSize,
        ),
        SizedBox(width: spacing),
        Text(
          text,
          style: textStyle ?? secondaryTextStyle(color: Colors.black),
        ).expand(),
      ],
    );
  }
}
