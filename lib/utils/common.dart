import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/utils/images.dart';
import 'package:ticky/utils/widgets/custom_web_view_asset_widget.dart' show CustomWebViewAssetWidget;

import 'date_utils.dart';

String parseHtmlString(String? htmlString) {
  return parse(parse(htmlString).body!.text).documentElement!.text;
}

class FilePickerFunctions {
  static Widget FilePickerPopupMenu({
    required Function(List<File> file) onFileSelection,
    BoxDecoration? decoration,
    IconData? icon,
    Widget? child,
    bool isFile = true,
    bool isAllowMultiple = false,
  }) {
    return PopupMenuButton(
      child: Container(
        decoration: decoration,
        child: child ?? Icon(icon ?? Icons.attachment_rounded, size: 20).paddingAll(3),
      ),
      padding: EdgeInsets.zero,
      style: ButtonStyle(
        visualDensity: VisualDensity.compact,
        padding: WidgetStatePropertyAll(EdgeInsets.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      position: PopupMenuPosition.under,
      menuPadding: EdgeInsets.zero,
      onSelected: (value) async {
        await Future.delayed(
          Duration(
            milliseconds: 500,
          ),
        );
        if (value == 1) {
          List<File> res = await FilePickerFunctions.getMultipleFile(useCamera: true);
          onFileSelection.call(res);
        } else if (value == 2) {
          List<File> res = await FilePickerFunctions.getMultipleFile(allowMultiple: isAllowMultiple, useGallery: true);
          onFileSelection.call(res);
        } else if (value == 3) {
          List<File> res = await FilePickerFunctions.getMultipleFile(allowMultiple: isAllowMultiple);
          onFileSelection.call(res);
        }
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            padding: EdgeInsets.symmetric(horizontal: 12),
            value: 1,
            child: Row(
              children: [
                Icon(Icons.camera_alt_outlined, size: 20),
                16.width,
                Text("Camera", style: primaryTextStyle()),
              ],
            ),
          ),
          PopupMenuItem(
            padding: EdgeInsets.symmetric(horizontal: 12),
            value: 2,
            child: Row(
              children: [
                Icon(Icons.photo_outlined, size: 20),
                16.width,
                Text("Photos", style: primaryTextStyle()),
              ],
            ),
          ),
          if (isFile)
            PopupMenuItem(
              padding: EdgeInsets.symmetric(horizontal: 12),
              value: 3,
              child: Row(
                children: [
                  Icon(Icons.file_copy_outlined, size: 20),
                  16.width,
                  Text("Files", style: primaryTextStyle()),
                ],
              ),
            ),
        ];
      },
    );
  }

  static Future<File?> cropImage(File imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.blue,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPresetCustom(),
          ],
        ),
        IOSUiSettings(
          title: 'Crop Image',
          doneButtonTitle: 'Done',
          cancelButtonTitle: 'Cancel',
          rotateButtonsHidden: false,
          rotateClockwiseButtonHidden: false,
          aspectRatioPickerButtonHidden: false,
          resetAspectRatioEnabled: true,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPresetCustom(), // IMPORTANT: iOS supports only one custom aspect ratio in preset list
          ],
          minimumAspectRatio: 1.0, // Ensures good quality cropping
        ),
      ],
    );

    if (croppedFile != null) {
      return File(croppedFile.path);
    }
    return null; // Return null if the user cancels cropping
  }

  static Future<List<File>> getMultipleFile({bool allowMultiple = true, List<String>? allowedExtensions, bool useGallery = false, bool useCamera = false}) async {
    final ImagePicker picker = ImagePicker();
    XFile? xFile;
    FilePickerResult? filePickerResult;
    List<File> imgList = [];

    if (useCamera) {
      xFile = await picker.pickImage(source: ImageSource.camera);
      if (xFile != null) {
        imgList.add(File(xFile.path));
      }
    } else {
      filePickerResult = await FilePicker.platform.pickFiles(
        allowMultiple: allowMultiple,
        allowedExtensions: useGallery ? [] : allowedExtensions ?? ["pdf", "jpg", "png", "jpeg", "doc"],
        type: useGallery ? FileType.image : FileType.custom,
      );

      if (filePickerResult != null) {
        imgList = filePickerResult.paths.whereType<String>().map((path) => File(path)).toList();
      }
    }

    return imgList;
  }
}

String formatClockInDateTime(DateTime dateTime, {String? format}) {
  return DateFormat(format ?? 'dd MMM yyyy hh:mm:ss a').format(dateTime);
}

Stream<String> timerStreamFromDateTime(DateTime startDateTime) async* {
  while (true) {
    // Get the current time
    final currentTime = DateTimeUtils.convertDateTimeToUTC(
      dateTime: DateTime.now(),
    );

    // Calculate the elapsed time between current time and start time
    final duration = currentTime.difference(startDateTime);

    // Format the duration into a more human-readable ISO 8601 duration
    final totalTime = _formatDuration(duration);

    // Emit the total elapsed time in ISO 8601 duration format
    yield totalTime;

    // Delay for 1 second before updating the time
    await Future.delayed(Duration(seconds: 1));
  }
}

/// Helper function to format [Duration] into an ISO 8601-like string (HH:MM:SS).
String _formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));

  // Return the formatted time in HH:MM:SS
  return "$hours:$minutes:$seconds";
}

class ShowAlertDialogWithMediaOptions {
  static Future<void> displayAdaptiveAlertDialog({
    required BuildContext context,
    required List<Widget> actions,
    bool barrierDismissible = false,
    double top = 0,
    double left = 0,
    double? width,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return Stack(
          children: [
            Positioned(
              top: top,
              left: left,
              width: width ?? MediaQuery.sizeOf(context).width * 0.65,
              child: AlertDialog(
                alignment: Alignment.center,
                elevation: 2,
                backgroundColor: Colors.white,
                actionsPadding: EdgeInsets.symmetric(vertical: 15),
                actions: actions,
              ),
            ),
          ],
        );
      },
    );
  }
}

class CropAspectRatioPresetCustom implements CropAspectRatioPresetData {
  @override
  (int, int)? get data => (2, 3);

  @override
  String get name => '2x3 (customized)';
}

Future<void> checkGdprConsent() async {
  afterBuildCreated(
    () async {
      if (!userStore.gdprConsent.validate().getBoolInt()) {
        await showInDialog(
          getContext,
          barrierDismissible: false,
          contentPadding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(borderRadius: radius()),
          insetPadding: EdgeInsets.symmetric(vertical: 32),
          builder: (context) {
            return CustomWebViewAssetWidget(
              showBack: false,
              assetFile: AppImages.gdpr_consent,
              title: "GDPR Consent",
            ).withWidth(context.width() * 0.9);
          },
        );
      }
    },
  );
}
