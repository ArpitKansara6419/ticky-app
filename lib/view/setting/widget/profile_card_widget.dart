import 'dart:io';

import 'package:ag_widgets/widgets/ag_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/auth/user_data.dart';
import 'package:ticky/utils/common.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/utils/widgets/app_loader.dart';
import 'package:ticky/utils/widgets/no_data_custom_widget.dart';

class ProfileCardWidget extends StatelessWidget {
  final User data;

  const ProfileCardWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
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
                child: Observer(
                  builder: (context) {
                    if (appLoaderStore.appLoadingState[AppLoaderStateName.personalDataApiState].validate())
                      return Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                        child: aimLoader(context, size: 20),
                      );
                    if (personalDetailsStore.profilePictureFiles.validate().isNotEmpty) {
                      final profilePictureFile = personalDetailsStore.profilePictureFiles.validate().first;

                      // Check if the file path is valid and the file exists
                      if (profilePictureFile.existsSync()) {
                        return Image.file(
                          profilePictureFile,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ).cornerRadiusWithClipRRect(160);
                      } else {
                        return AgCachedImage(
                          imageUrl: "${data.profileImage.validate().getImageWithBaseUrl}",
                          width: 80,
                          backgroundColorList: darkBrightColors,
                          fullName: '${data.firstName} ${data.lastName}',
                          textSize: 25,
                          isShowName: true,
                          height: 80,
                          isCircle: true,
                        );
                      }
                    }
                    return AgCachedImage(
                      imageUrl: "${data.profileImage.validate().getImageWithBaseUrl}",
                      width: 80,
                      backgroundColorList: darkBrightColors,
                      fullName: '${data.firstName} ${data.lastName}',
                      textSize: 25,
                      isShowName: true,
                      height: 80,
                      isCircle: false,
                    ).cornerRadiusWithClipRRect(160);
                  },
                ),
              ),
              Positioned(
                bottom: -0,
                right: -5,
                child: FilePickerFunctions.FilePickerPopupMenu(
                  isFile: true,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: defaultBoxShadow(spreadRadius: 2, blurRadius: 2),
                  ),
                  icon: Icons.upload_outlined,
                  onFileSelection: (List<File> file) async {
                    File? croppedImage = await FilePickerFunctions.cropImage(file.first);
                    if (croppedImage != null) {
                      file = [croppedImage];
                    }
                    await personalDetailsStore.setProfilePictureFiles(file: file);

                    if (personalDetailsStore.profilePictureFiles.validate().isNotEmpty) {
                      showConfirmDialogCustom(
                        context,
                        title: "Confirm Profile Image?",
                        subTitle: "Are you sure you want to set this image as your profile picture? You can update it later if needed.",
                        primaryColor: primaryColor,
                        dialogType: DialogType.CONFIRMATION,
                        onCancel: (p0) => personalDetailsStore.setProfilePictureFiles(file: []),
                        onAccept: (BuildContext) => personalDetailsStore.onProfileSubmit(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          4.height,
          Text('${data.firstName} ${data.lastName}', style: boldTextStyle(size: 24)),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${data.email.validate()}', style: secondaryTextStyle(size: 13)),
              4.width,
              Icon(Icons.verified, color: data.emailVerification.getBoolInt() ? Colors.green : Colors.grey, size: 18),
            ],
          ),
          4.height,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${data.contact.validate()}', style: secondaryTextStyle(size: 13)),
              8.width,
              Icon(Icons.verified, color: data.phoneVerification.getBoolInt() ? Colors.green : Colors.grey, size: 18),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (data.jobTitle.validate().isNotEmpty) ...{
                Text('${data.jobType.validate().getJobType()}', style: secondaryTextStyle(size: 13)),
                8.width,
                Text('|', style: secondaryTextStyle(size: 13)),
                8.width,
                Text('${data.jobTitle.toString()}', style: secondaryTextStyle(size: 13)),
              }
            ],
          ),
          16.height,
        ],
      ),
    );
  }
}

class ChooseDestinationInMediaAlertComponent extends StatelessWidget {
  const ChooseDestinationInMediaAlertComponent({
    super.key,
    required this.label,
    required this.icon,
    this.onTap,
  });

  final String label;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: secondaryTextStyle(size: 16, color: Colors.black),
            ),
            Icon(
              icon,
              color: Colors.black,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}
