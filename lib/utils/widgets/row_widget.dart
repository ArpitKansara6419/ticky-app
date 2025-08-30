import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class RowWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  final TextStyle? textStyle;
  final double iconSize;
  final double spacing;

  const RowWidget({
    Key? key,
    required this.icon,
    required this.text,
    this.iconColor = Colors.green,
    this.textStyle,
    this.iconSize = 16,
    this.spacing = 4.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: iconSize),
        SizedBox(width: spacing),
        Text(
          text,
          style: textStyle ?? secondaryTextStyle(color: iconColor),
        ).expand(),
      ],
    );
  }
}
