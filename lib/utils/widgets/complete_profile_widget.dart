import 'dart:io';

import 'package:ag_widgets/extension/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/view/setting/engineer/engineer_profile_screen.dart';

class CompleteProfileWidget extends StatelessWidget {
  const CompleteProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      int? percentage = authStore.profileCompletionData?.profileCompletionData!.calculateProfileCompletion().toInt();
      if (percentage == 100) return Offstage();
      return Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: radius()),
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSvgIcons.icCompleteProfile.agLoadImage(height: 60, width: 40),
                8.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${percentage.validate()}% " + ' of your profile is completed !!',
                      style: boldTextStyle(color: context.primaryColor, size: 18),
                    ),
                    8.height,
                    LinearProgressIndicator(
                      value: percentage.validate() / 100,
                      backgroundColor: Colors.grey[300],
                      color: context.primaryColor,
                      minHeight: 6,
                      borderRadius: radius(),
                    ),
                    8.height,
                    if (percentage.validate() < 100)
                      Text(
                        'Complete your profile to showcase your skills, stay visible, and boost your chances for top opportunities!',
                        style: secondaryTextStyle(size: 12),
                      )
                    else
                      Text("Congratulations! Your profile is complete.", style: secondaryTextStyle()),
                    8.height,
                    AppButton(
                      padding: EdgeInsets.only(top: 0, bottom: 0, left: 12, right: 12),
                      color: context.primaryColor,
                      textStyle: primaryTextStyle(color: Colors.white, size: 12),
                      text: "Complete Profile",
                      onTap: () {
                        dashboardStore.setBottomNavigationCurrentIndex(3);
                        EngineerProfileScreen().launch(context, pageRouteAnimation: Platform.isIOS ? null : PageRouteAnimation.Slide);
                      },
                    )
                  ],
                ).expand(),
              ],
            ),
          ],
        ),
      );
    });
  }
}
