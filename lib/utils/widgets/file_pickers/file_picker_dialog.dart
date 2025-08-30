import 'package:ticky/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class FilePickerDialog extends StatelessWidget {
  final bool isSelected;

  FilePickerDialog({this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SettingItemWidget(
            title: "Remove Image",
            titleTextStyle: primaryTextStyle(),
            leading: Icon(Icons.close, color: context.iconColor),
            onTap: () {
              finish(context, FileTypes.CANCEL);
            },
          ).visible(isSelected),
          SettingItemWidget(
            title: "Camera",
            titleTextStyle: primaryTextStyle(),
            leading: Icon(LineIcons.camera, color: context.iconColor),
            onTap: () {
              finish(context, FileTypes.CAMERA);
            },
          ).visible(!isWeb),
          SettingItemWidget(
            title: "Gallery",
            titleTextStyle: primaryTextStyle(),
            leading: Icon(LineIcons.image_1, color: context.iconColor),
            onTap: () {
              finish(context, FileTypes.GALLERY);
            },
          ),
        ],
      ),
    );
  }
}
