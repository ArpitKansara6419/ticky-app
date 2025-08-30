import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:ticky/controller/engineer/master_data_controller/master_data_controller.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/utils/colors.dart';
import 'package:ticky/utils/functions.dart';
import 'package:timezone/data/latest.dart';

void initialFunction() async {
  await initialize();
  packageInfo = await PackageInfo.fromPlatform();

  initializeTimeZones();

  appButtonBackgroundColorGlobal = primaryColor;
  appBarBackgroundColorGlobal = primaryColor;
  defaultAppButtonTextColorGlobal = Colors.white;
  defaultRadius = 6;
  defaultAppButtonRadius = 26;
  defaultAppButtonShapeBorder = RoundedRectangleBorder(borderRadius: radius(defaultAppButtonRadius));
  defaultBlurRadius = 0;
  defaultSpreadRadius = 0;
  defaultElevation = 0;

  textBoldSizeGlobal = 16;
  textPrimarySizeGlobal = 16;
  textSecondarySizeGlobal = 14;

  userStore.setLoggedIn(getBoolAsync(SharePreferencesKey.loggedIn), isInitializing: true);

  if (userStore.isLoggedIn) {
    userStore.setAccessToken(getStringAsync(SharePreferencesKey.accessToken), isInitializing: true);
    userStore.setFirebaseToken(getStringAsync(SharePreferencesKey.firebaseToken), isInitializing: true);
    userStore.setUserId(getIntAsync(SharePreferencesKey.userId), isInitializing: true);
    userStore.setFirstName(getStringAsync(SharePreferencesKey.firstName), isInitializing: true);
    userStore.setLastName(getStringAsync(SharePreferencesKey.lastName), isInitializing: true);
    userStore.setEmail(getStringAsync(SharePreferencesKey.email), isInitializing: true);
    userStore.setProfileImage(getStringAsync(SharePreferencesKey.profileImage), isInitializing: true);
    userStore.setPhoneNumber(getStringAsync(SharePreferencesKey.phoneNumber), isInitializing: true);
    userStore.setCountryCodeNumber(getStringAsync(SharePreferencesKey.countryCodeNumber), isInitializing: true);
    userStore.setJobType(getStringAsync(SharePreferencesKey.jobType), isInitializing: true);
    userStore.setJobTitle(getStringAsync(SharePreferencesKey.jobTitle), isInitializing: true);
    userStore.setCheckInTime(getStringAsync(SharePreferencesKey.checkInTime), isInitializing: true);
    userStore.setCheckOutTime(getStringAsync(SharePreferencesKey.checkOutTime), isInitializing: true);
    userStore.setPhoneNumberVerified(getBoolAsync(SharePreferencesKey.phoneNumberVerified), isInitializing: true);
    userStore.setCurrencyCodeVerified(getStringAsync(SharePreferencesKey.currencyCode), isInitializing: true);
    userStore.setEmailVerified(getBoolAsync(SharePreferencesKey.emailVerified), isInitializing: true);
    userStore.setGdprConsentVerified(getIntAsync(SharePreferencesKey.gdprConsent), isInitializing: true);
    MasterDataController.fetchAllData(isSaveDetail: false).catchError((e) => log(e.toString()));
  }
}
