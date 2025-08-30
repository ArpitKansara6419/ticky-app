import 'dart:io';

import 'package:ag_widgets/ag_widgets.dart';
import 'package:ag_widgets/widgets/ag_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/utils/colors.dart';
import 'package:ticky/utils/images.dart';
import 'package:ticky/view/setting/engineer/engineer_profile_screen.dart';

class HeaderComponent extends StatelessWidget implements PreferredSizeWidget {
  final String? name;
  final bool isHide;

  const HeaderComponent({Key? key, this.name, this.isHide = true}) : super(key: key);

  Widget build(BuildContext context) {
    return AppBar(
      leading: AppImages.appLogo.agLoadImage(height: 42, width: 42, fit: BoxFit.contain).paddingSymmetric(horizontal: 4, vertical: 10),
      titleSpacing: 0,
      scrolledUnderElevation: 0,
      backgroundColor: context.scaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
      actions: isHide.validate()
          ? [
              GradientBorder(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFEDA77), // Yellow
                    Color(0xFFF58529), // Orange
                    Color(0xFFDD2A7B), // Pink
                    Color(0xFF8134AF), // Purple
                    Color(0xFF515BD4), // Blue
                  ],
                ),
                strokeWidth: 2,
                borderRadius: 100,
                child: InkWell(
                  borderRadius: radius(200),
                  onTap: () async {
                    await biometricAuthStore.authenticate().catchError(onError);
                    if (!biometricAuthStore.isLocked) {
                      await EngineerProfileScreen().launch(context, pageRouteAnimation: Platform.isIOS ? null : PageRouteAnimation.Slide);
                      biometricAuthStore.dispose();
                    }
                  },
                  child: Observer(builder: (context) {
                    return Stack(
                      children: [
                        AgCachedImage(
                          imageUrl: userStore.profileImage.validate(),
                          fullName: userStore.firstName.validate(),
                          isShowName: true,
                          isCircle: true,
                          backgroundColorList: darkBrightColors,
                          height: 36,
                          width: 36,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: defaultBoxShadow(blurRadius: 2, spreadRadius: 4)),
                            padding: EdgeInsets.all(2),
                            child: Icon(Icons.fingerprint, color: primaryColor, size: 12),
                          ),
                        )
                      ],
                    );
                  }),
                ),
              ).paddingRight(8),
            ]
          : null,
      title: Text(name.validate(), style: boldTextStyle(color: Colors.black, size: 18)),
      automaticallyImplyLeading: false,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
