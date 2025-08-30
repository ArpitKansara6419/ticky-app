import 'dart:io';

// import 'package:background_location_tracker/background_location_tracker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/auth/auth_api_controller.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/controller/store/user_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/utils/common.dart';
import 'package:ticky/utils/date_utils.dart';
import 'package:ticky/utils/enums.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/utils/widgets/custom_web_view_widget.dart';
import 'package:ticky/view/auth/change_password_screen.dart';
import 'package:ticky/view/auth/sign_in_screen.dart';
import 'package:ticky/view/component/header_component.dart';
import 'package:ticky/view/setting/engineer/engineer_profile_screen.dart';
import 'package:ticky/view/setting/holiday/holiday_list_screen.dart';
import 'package:ticky/view/setting/leaves/my_leave_screen.dart';
import 'package:ticky/view/setting/payouts/payout_profile_screen.dart';
import 'package:ticky/view/setting/permission/permission_view.dart';
import 'package:ticky/view/setting/widget/notification_screen.dart';
import 'package:ticky/view/setting/widget/profile_card_widget.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    await checkGdprConsent();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    settingGlobalKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: settingGlobalKey,
      appBar: HeaderComponent(name: MenuName.settings, isHide: false),
      body: AnimatedScrollView(
        listAnimationType: ListAnimationType.None,
        children: [
          Observer(
            builder: (context) {
              final userValue = userStore.lastUpdatedUserValue;

              if (userValue != null && (userValue.userData != null || userValue.user != null)) {
                return ProfileCardWidget(
                  data: userValue.userData ?? userValue.user!,
                );
              }

              return SizedBox();
            },
          ),
          Text('Account', style: boldTextStyle(color: context.primaryColor, size: 16)).paddingSymmetric(horizontal: 16),
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: radius()),
            margin: EdgeInsets.all(8),
            child: Column(
              children: [
                SettingItemWidget(
                  leading: buildLeadingWidget(context, image: AppSvgIcons.icProfile, color: context.iconColor),
                  title: "My Profile",
                  trailing: buildTrailingWidget(context, iconData: Icons.fingerprint, size: 22),
                  onTap: () async {
                    await biometricAuthStore.authenticate().catchError(onError);
                    if (!biometricAuthStore.isLocked) {
                      await EngineerProfileScreen().launch(context, pageRouteAnimation: Platform.isIOS ? null : PageRouteAnimation.Slide);
                      biometricAuthStore.dispose();
                    }

                    setState(() {});
                  },
                ),
                buildDividerWidget(),
                SettingItemWidget(
                  leading: buildLeadingWidget(context, image: AppSvgIcons.icStatement, color: context.iconColor),
                  title: "Payment & Payout Details",
                  trailing: buildTrailingWidget(context, iconData: Icons.fingerprint, size: 20),
                  onTap: () async {
                    await biometricAuthStore.authenticate().catchError(onError);

                    if (!biometricAuthStore.isLocked) {
                      await PayoutProfileScreen().launch(context, pageRouteAnimation: Platform.isIOS ? null : PageRouteAnimation.Slide);
                      biometricAuthStore.dispose();
                    }
                  },
                ),
                if (userStore.jobType.validate() == "full_time") ...{
                  buildDividerWidget(),
                  SettingItemWidget(
                    leading: buildLeadingWidget(context, image: AppSvgIcons.icReport, color: context.iconColor),
                    title: "Leaves",
                    trailing: buildTrailingWidget(context),
                    onTap: () => MyLeaveScreen().launch(context),
                  ),
                },
                buildDividerWidget(),
                SettingItemWidget(
                  leading: buildLeadingWidget(context, image: AppSvgIcons.icStatement, color: context.iconColor),
                  title: "Holidays",
                  trailing: buildTrailingWidget(context),
                  onTap: () => HolidayListScreen().launch(context),
                ),
                buildDividerWidget(),
                SettingItemWidget(
                  leading: buildLeadingWidget(context, image: AppSvgIcons.icEngineer, color: context.iconColor),
                  title: "Change Password",
                  onTap: () => ChangePasswordScreen().launch(context, pageRouteAnimation: Platform.isIOS ? null : PageRouteAnimation.Slide),
                  trailing: buildTrailingWidget(context),
                ),
                buildDividerWidget(),
                SettingItemWidget(
                  leading: buildLeadingWidget(context, image: AppSvgIcons.icNotification, color: context.iconColor),
                  title: "Notifications",
                  onTap: () => NotificationScreen().launch(context, pageRouteAnimation: Platform.isIOS ? null : PageRouteAnimation.Slide),
                  trailing: buildTrailingWidget(context),
                ),
                buildDividerWidget(),
                SettingItemWidget(
                  leading: buildLeadingWidget(context, image: AppSvgIcons.icPermission, color: context.iconColor),
                  title: "Permissions Details",
                  trailing: buildTrailingWidget(context),
                  onTap: () async {
                    await PermissionView().launch(context, pageRouteAnimation: Platform.isIOS ? null : PageRouteAnimation.Slide);
                  },
                ),
              ],
            ),
          ),
          16.height,
          Text('Legal & Support', style: boldTextStyle(color: context.primaryColor, size: 16)).paddingSymmetric(horizontal: 16),
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: radius()),
            margin: EdgeInsets.all(8),
            child: Column(
              children: [
                SettingItemWidget(
                  leading: buildLeadingWidget(context, image: AppSvgIcons.icTerms, color: context.iconColor),
                  title: "Terms & Conditions",
                  trailing: buildTrailingWidget(context),
                  onTap: () => CustomWebViewWidget(url: TermsAndConditionsUrl, title: "Terms & Conditions", showBack: true).launch(context),
                ),
                buildDividerWidget(),
                SettingItemWidget(
                  leading: buildLeadingWidget(context, image: AppSvgIcons.icPrivacyProperty, color: context.iconColor),
                  title: "Privacy Policy",
                  trailing: buildTrailingWidget(context),
                  onTap: () => CustomWebViewWidget(url: PrivacyPolicyUrl, title: "Privacy Policy", showBack: true).launch(context),
                ),
                buildDividerWidget(),
                SettingItemWidget(
                  leading: buildLeadingWidget(context, image: AppSvgIcons.icPrivacyProperty, color: context.iconColor),
                  title: "App Version",
                  trailing: FutureBuilder(
                    future: getPackageInfo(),
                    builder: (context, snap) {
                      return Text("${snap.data?.versionName.validate()}", style: secondaryTextStyle());
                    },
                  ),
                ),
              ],
            ),
          ),
          Observer(
            builder: (context) => TextButton.icon(
              onPressed: () {
                showConfirmDialogCustom(
                  context,
                  dialogType: DialogType.ACCEPT,
                  primaryColor: context.theme.colorScheme.error,
                  title: "Confirm Logout",
                  subTitle: 'Are you sure you want to log out? You will need to log in again to access your account.',
                  onAccept: (p0) async {
                    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.setLogOutApiState, value: true);
                    await AuthApiController.logoutApi();
                    userStore.logout();
                    mainLog(message: 'BackgroundLocationTrackerManager.stopTracking');
                    UserStore().setLoggedIn(false);
                    dashboardStore.bottomNavigationCurrentIndex = 0;
                    SignInScreen().launch(context, pageRouteAnimation: Platform.isIOS ? null : PageRouteAnimation.Slide, isNewTask: true);
                    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.setLogOutApiState, value: false);
                  },
                );
              },
              icon: appLoaderStore.appLoadingState[AppLoaderStateName.setLogOutApiState].validate()
                  ? SizedBox.shrink()
                  : buildLeadingWidget(context, image: AppSvgIcons.icLogout, color: context.theme.colorScheme.error),
              label: appLoaderStore.appLoadingState[AppLoaderStateName.setLogOutApiState].validate()
                  ? SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(color: Colors.red, strokeWidth: 2),
                    )
                  : Text('Logout', style: boldTextStyle(size: 18, color: context.theme.colorScheme.error)),
            ).center(),
          ),

          /* 34.height,
          Divider(),
          Text('Danger Zone', style: boldTextStyle(color: context.theme.colorScheme.error, size: 16)).paddingSymmetric(horizontal: 16),
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: radius()),
            margin: EdgeInsets.all(8),
            child: Column(
              children: [
                Observer(builder: (context) {
                  return SettingItemWidget(
                    leading: buildLeadingWidget(context, image: AppSvgIcons.icEngineer, color: context.theme.colorScheme.error),
                    title: "Delete Account",
                    titleTextStyle: boldTextStyle(color: context.theme.colorScheme.error),
                    trailing: appLoaderStore.appLoadingState[AppLoaderStateName.deleteAccountApiState].validate()
                        ? aimLoader(context, size: 24)
                        : buildTrailingWidget(context, color: context.theme.colorScheme.error),
                    onTap: () {
                      showConfirmDialogCustom(
                        context,
                        primaryColor: context.theme.colorScheme.error,
                        title: "Delete Account",
                        subTitle: "Are you sure you want to delete your account? This action is irreversible, and all your data will be permanently deleted.",
                        onAccept: (p0) {
                          signupStore.onDeleteAccount(request: {"id": userStore.userId.validate()});
                        },
                      );
                    },
                  );
                }),
              ],
            ),
          ),*/
          16.height,
          Text(
            "©${DateTimeUtils.convertDateTimeToUTC(
              dateTime: DateTime.now(),
            ).year}. Made with ❤️ by Aimbot",
            style: secondaryTextStyle(color: context.primaryColor),
          ).center(),
          20.height,
          if (isIOS) 24.height,
        ],
      ),
    );
  }
}
