import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

Widget ScreenTitleWidget(String value, {int? size}) {
  return Text(value, style: boldTextStyle(size: size));
}

Widget ScreenSubTitleWidget(String value, {int? size}) {
  return Text(value, style: secondaryTextStyle(size: size));
}
