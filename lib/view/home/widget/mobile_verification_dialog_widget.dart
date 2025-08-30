import 'dart:io';

import 'package:ag_widgets/ag_widgets.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/view/setting/engineer/mobile_otp_verification_screen.dart';

class MobileVerificationDialogWidget extends StatelessWidget {
  const MobileVerificationDialogWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      radius: defaultRadius,
      borderRadius: radius(),
      onTap: () {
        MobileOtpVerificationScreen(
          countryCode: userStore.countryCodeNumber.validate(value: "+91"),
          mobileNumber: userStore.phoneNumber.validate(),
        ).launch(context, pageRouteAnimation: Platform.isIOS ? null : PageRouteAnimation.Slide);
      },
      child: Container(
        width: context.width(),
        padding: EdgeInsets.only(left: 8, right: 4, bottom: 4, top: 4),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: radius(),
        ),
        child: Row(
          children: [
            AppSvgIcons.icMobileVerification.agLoadImage(width: 40, height: 50),
            8.width,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Complete your verification", style: boldTextStyle()),
                4.height,
                Text("Verify your phone number to keep extra secure.", style: secondaryTextStyle(size: 12)),
              ],
            ).expand(),
            16.width,
            buildTrailingWidget(context, size: 16),
            16.width,

            /*  Text(
              "⚠️ Mobile Verification Pending ${userStore.countryCodeNumber.validate(value: "+91")}${userStore.phoneNumber} ",
              style: boldTextStyle(color: context.primaryColor, size: 14),
            ).expand(),
            16.width,
            TextButton(
              style: ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap, visualDensity: VisualDensity.compact),
              onPressed: () {
                MobileOtpVerificationScreen(
                  countryCode: userStore.countryCodeNumber.validate(value: "+91"),
                  mobileNumber: userStore.phoneNumber.validate(),
                ).launch(context, pageRouteAnimation: Platform.isIOS ? null: PageRouteAnimation.Slide);
              },
              child: Text("Verify Now", style: boldTextStyle(size: 12, color: context.theme.colorScheme.error)),
            )*/
          ],
        ),
      ),
    );
  }
}
