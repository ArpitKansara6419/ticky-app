import 'package:ag_widgets/extension/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/utils/colors.dart';

Widget buildTrailingWidget(BuildContext context, {IconData? iconData, Color? color, double? size}) {
  return Icon(iconData ?? Icons.arrow_forward_ios_rounded, size: size ?? 12, color: color ?? context.iconColor);
}

Widget buildLeadingWidget(BuildContext context, {required String? image, Color? color}) {
  return (image ?? "").agLoadImage(width: 22, height: 22, color: color ?? context.iconColor);
}

Widget buildDividerWidget() {
  return Divider(
    height: 0,
    indent: 0,
    color: borderColor,
  );
}
