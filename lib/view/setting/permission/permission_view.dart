import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/utils/colors.dart';
import 'package:ticky/utils/enums.dart';
import 'package:ticky/utils/widgets/app_scaffold_with_loader.dart';
import 'package:ticky/utils/widgets/common_app_bar.dart';

class PermissionView extends StatefulWidget {
  const PermissionView({super.key});

  @override
  State<PermissionView> createState() => _PermissionViewState();
}

class _PermissionViewState extends State<PermissionView> {
  bool isNotificationGranted = false;
  bool isStorageGranted = false;
  bool isLocationGranted = false;
  bool isCameraGranted = false;
  bool isPhotoGranted = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        permissionStore.loaderValue(true);
        NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
          alert: true,
          badge: true,
          sound: true,
        );
        isNotificationGranted = settings.authorizationStatus == AuthorizationStatus.authorized;

        isStorageGranted = await Permission.manageExternalStorage.isGranted;
        isLocationGranted = await Permission.location.isGranted;
        isCameraGranted = await Permission.camera.isGranted;
        isPhotoGranted = await Permission.photos.isGranted;
        permissionStore.loaderValue(false);
      },
    );

    super.initState();
  }

  bool isAllPermissionGranted() => isNotificationGranted && isLocationGranted && isCameraGranted && isPhotoGranted;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => AppScaffoldWithLoader(
        isLoading: permissionStore.loader,
        child: Scaffold(
          appBar: commonAppBarWidget("Permissions"),
          body: AnimatedScrollView(
            padding: EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 24,
            ),
            children: [
              PermissionComponent(
                icon: Icons.notifications_active_rounded,
                title: 'Notification',
                description: "Allows the app to send you alerts, updates, and reminders even when you're not actively using it.",
                isGranted: isNotificationGranted,
              ),
              // dividerBetweenPermissionList(),
              // PermissionComponent(
              //   icon: Icons.storage,
              //   title: 'Storage',
              //   description: "Lets the app read and write files to your device’s storage, such as downloads, documents, or cache.",
              //   isGranted: isStorageGranted,
              // ),
              dividerBetweenPermissionList(),
              PermissionComponent(
                icon: Icons.location_on,
                title: 'Location',
                description: "Grants access to your device’s location to provide location-based services or personalized experiences.",
                isGranted: isLocationGranted,
              ),
              dividerBetweenPermissionList(),
              PermissionComponent(
                icon: Icons.camera_alt,
                title: 'Camera',
                description: "Enables the app to capture photos or videos using your device’s camera for in-app functionality.",
                isGranted: isCameraGranted,
              ),
              dividerBetweenPermissionList(),
              PermissionComponent(
                icon: Icons.photo,
                title: 'Photos',
                description: "Allows the app to access your photo gallery for selecting or uploading images from your device.",
                isGranted: isPhotoGranted,
              ),
              40.height,
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () async {
                    mainLog(
                      message:
                          'isNotificationGranted => $isNotificationGranted \nisStorageGranted => $isStorageGranted \nisLocationGranted => $isLocationGranted \nisCameraGranted => $isCameraGranted \nisPhotoGranted => $isPhotoGranted',
                    );

                    if (isAllPermissionGranted()) return;

                    /// Notification permission
                    if (!isNotificationGranted) {
                      NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
                        alert: true,
                        badge: true,
                        sound: true,
                      );
                      mainLog(
                        message: '${settings.authorizationStatus}',
                        label: 'settings.authorizationStatus => ',
                      );
                      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
                        isNotificationGranted = true;
                      }
                      await Future.delayed(Duration(milliseconds: 500));
                    }

                    /// Storage permission
                    if (!isStorageGranted) {
                      PermissionStatus permissionStatus = await Permission.manageExternalStorage.request();
                      mainLog(
                        message: '$permissionStatus',
                        label: 'permissionStatus of storage => ',
                      );
                      if (permissionStatus == PermissionStatus.granted || permissionStatus == PermissionStatus.limited) {
                        isStorageGranted = true;
                      }
                      await Future.delayed(Duration(milliseconds: 500));
                    }

                    /// Location permission
                    if (!isLocationGranted) {
                      PermissionStatus permissionStatus = await Permission.location.request();
                      mainLog(
                        message: '$permissionStatus',
                        label: 'permissionStatus of location => ',
                      );
                      if (permissionStatus == PermissionStatus.granted || permissionStatus == PermissionStatus.limited) {
                        isLocationGranted = true;
                      }
                      await Future.delayed(Duration(milliseconds: 500));
                    }

                    /// Camera permission
                    if (!isCameraGranted) {
                      PermissionStatus permissionStatus = await Permission.camera.request();
                      mainLog(
                        message: '$permissionStatus',
                        label: 'permissionStatus of camera => ',
                      );
                      if (permissionStatus == PermissionStatus.granted || permissionStatus == PermissionStatus.limited) {
                        isCameraGranted = true;
                      }
                      await Future.delayed(Duration(milliseconds: 500));
                    }

                    /// Photo permission
                    if (!isPhotoGranted) {
                      PermissionStatus permissionStatus = await Permission.photos.request();
                      mainLog(
                        message: '$permissionStatus',
                        label: 'permissionStatus of photos => ',
                      );
                      if (permissionStatus == PermissionStatus.granted || permissionStatus == PermissionStatus.limited) {
                        isPhotoGranted = true;
                      }
                    }
                    setState(() {});
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: isAllPermissionGranted() ? Colors.black.withAlpha((255 * 0.2).toInt()) : primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  ),
                  child: Text(
                    'Request Permission',
                    style: secondaryTextStyle(
                      color: isAllPermissionGranted() ? Colors.black.withAlpha((255 * 0.5).toInt()) : Colors.white,
                      weight: FontWeight.w600,
                      size: 16,
                    ),
                  ),
                ),
              ),
              20.height,
            ],
          ),
        ),
      ),
    );
  }

  Widget dividerBetweenPermissionList() => Column(
        children: [
          20.height,
          Divider(
            color: Colors.black.withAlpha(
              (255 * 0.25).toInt(),
            ),
            thickness: 0.5,
            height: 0.5,
          ),
          20.height,
        ],
      );
}

class PermissionComponent extends StatelessWidget {
  const PermissionComponent({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.isGranted = false,
  });

  final IconData icon;
  final String title;
  final String description;
  final bool isGranted;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.black,
          size: 24,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: secondaryTextStyle(
                color: Colors.black,
                weight: FontWeight.w700,
                size: 16,
              ),
            ),
            4.height,
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.6,
              child: Text(
                description,
                maxLines: 10,
                softWrap: true,
                style: secondaryTextStyle(
                  color: Colors.black,
                  size: 14,
                ),
              ),
            ),
          ],
        ),
        Icon(
          isGranted ? Icons.check : Icons.warning,
          color: isGranted ? greenColor : Colors.redAccent,
          size: 20,
        ),
      ],
    );
  }
}
