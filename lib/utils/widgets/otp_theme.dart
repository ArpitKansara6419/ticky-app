import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pinput/pinput.dart';
import 'package:ticky/utils/colors.dart';

PinTheme defaultPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: boldTextStyle(),
  decoration: BoxDecoration(borderRadius: radius(), border: Border.all(color: borderColor)),
);

PinTheme focusedPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: boldTextStyle(),
  decoration: BoxDecoration(borderRadius: radius(), border: Border.all(color: primaryColor)),
);

PinTheme errorPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: boldTextStyle(),
  decoration: BoxDecoration(borderRadius: radius(), border: Border.all(color: Colors.redAccent)),
);
