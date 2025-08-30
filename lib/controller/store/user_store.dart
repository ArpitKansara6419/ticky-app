import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/auth/login_response.dart';
import 'package:ticky/utils/imports.dart';

part 'user_store.g.dart';

class UserStore = UserStoreBase with _$UserStore;

abstract class UserStoreBase with Store {
  @observable
  String? firstName;

  @observable
  int? userId;

  @observable
  String? lastName;

  @observable
  String? email;

  @observable
  String? phoneNumber;

  @observable
  String? countryCodeNumber;

  @observable
  String? profileImage;

  @observable
  String? accessToken;

  @observable
  String? firebaseToken;

  @observable
  int? gdprConsent;

  @observable
  bool isLoggedIn = false;

  @observable
  bool? isEmailVerified = false;

  @observable
  bool? isPhoneNumberVerified = false;

  @observable
  String? currencyCode;

  @observable
  String? jobTitle;
  @observable
  String? jobType;

  @observable
  String? checkInTime;

  @observable
  String? checkOutTime;

  @observable
  LoginResponse? lastUpdatedUserValue;

  @action
  Future<void> setUserId(int val, {bool isInitializing = false}) async {
    userId = val;
    if (!isInitializing) await setValue(SharePreferencesKey.userId, val);
  }

  @action
  Future<void> setJobType(String val, {bool isInitializing = false}) async {
    jobType = val;
    if (!isInitializing) await setValue(SharePreferencesKey.jobType, val);
  }

  @action
  Future<void> setJobTitle(String val, {bool isInitializing = false}) async {
    jobTitle = val;
    if (!isInitializing) await setValue(SharePreferencesKey.jobTitle, val);
  }

  @action
  Future<void> setCheckInTime(String val, {bool isInitializing = false}) async {
    checkInTime = val;
    if (!isInitializing) await setValue(SharePreferencesKey.checkInTime, val);
  }

  @action
  Future<void> setCheckOutTime(String val, {bool isInitializing = false}) async {
    checkOutTime = val;
    if (!isInitializing) await setValue(SharePreferencesKey.checkOutTime, val);
  }

  @action
  Future<void> setLoggedIn(bool val, {bool isInitializing = false}) async {
    isLoggedIn = val;
    if (!isInitializing) await setValue(SharePreferencesKey.loggedIn, val);
  }

  @action
  Future<void> setFirstName(String val, {bool isInitializing = false}) async {
    firstName = val;
    if (!isInitializing) await setValue(SharePreferencesKey.firstName, val);
  }

  @action
  Future<void> setPhoneNumber(String val, {bool isInitializing = false}) async {
    phoneNumber = val;
    if (!isInitializing) await setValue(SharePreferencesKey.phoneNumber, val);
  }

  @action
  Future<void> setCountryCodeNumber(String val, {bool isInitializing = false}) async {
    countryCodeNumber = val;
    if (!isInitializing) await setValue(SharePreferencesKey.countryCodeNumber, val);
  }

  @action
  Future<void> setProfileImage(String val, {bool isInitializing = false}) async {
    profileImage = val;
    if (!isInitializing) await setValue(SharePreferencesKey.profileImage, val);
  }

  @action
  Future<void> setLastName(String val, {bool isInitializing = false}) async {
    lastName = val;
    if (!isInitializing) await setValue(SharePreferencesKey.lastName, val);
  }

  @action
  Future<void> setEmail(String val, {bool isInitializing = false}) async {
    email = val;
    if (!isInitializing) await setValue(SharePreferencesKey.email, val);
  }

  @action
  Future<void> setAccessToken(String val, {bool isInitializing = false}) async {
    accessToken = val;
    if (!isInitializing) await setValue(SharePreferencesKey.accessToken, val);
  }

  @action
  Future<void> setFirebaseToken(String val, {bool isInitializing = false}) async {
    firebaseToken = val;
    if (!isInitializing) await setValue(SharePreferencesKey.firebaseToken, val);
  }

  @action
  Future<void> setEmailVerified(bool val, {bool isInitializing = false}) async {
    isEmailVerified = val;
    if (!isInitializing) await setValue(SharePreferencesKey.emailVerified, val);
  }

  @action
  Future<void> setPhoneNumberVerified(bool val, {bool isInitializing = false}) async {
    isPhoneNumberVerified = val;
    if (!isInitializing) await setValue(SharePreferencesKey.phoneNumberVerified, val);
  }

  @action
  Future<void> setCurrencyCodeVerified(String val, {bool isInitializing = false}) async {
    currencyCode = val;
    if (!isInitializing) await setValue(SharePreferencesKey.currencyCode, val);
  }

  @action
  Future<void> setGdprConsentVerified(int val, {bool isInitializing = false}) async {
    gdprConsent = val;
    if (!isInitializing) await setValue(SharePreferencesKey.gdprConsent, val);
  }

  @action
  Future<void> logout() async {
    setValue(SharePreferencesKey.loggedIn, null);
    setValue(SharePreferencesKey.firstName, null);
    setValue(SharePreferencesKey.lastName, null);
    setValue(SharePreferencesKey.email, null);
    setValue(SharePreferencesKey.phoneNumber, null);
    setValue(SharePreferencesKey.countryCodeNumber, null);
    setValue(SharePreferencesKey.profileImage, null);
    setValue(SharePreferencesKey.accessToken, null);
    setValue(SharePreferencesKey.emailVerified, null);
    setValue(SharePreferencesKey.phoneNumberVerified, null);
    setValue(SharePreferencesKey.currencyCode, null);
    setValue(SharePreferencesKey.userId, null);
    setValue(SharePreferencesKey.jobType, null);
    setValue(SharePreferencesKey.jobTitle, null);
    setValue(SharePreferencesKey.checkInTime, null);
    setValue(SharePreferencesKey.checkOutTime, null);
    setValue(SharePreferencesKey.clockIn, null);
    setValue(SharePreferencesKey.startWorkTime, null);
    setValue(SharePreferencesKey.startIsTaskWork, null);
    setValue(SharePreferencesKey.gdprConsent, null);
    setValue(SharePreferencesKey.isRemember, null);
    setValue(SharePreferencesKey.firebaseToken, null);
    userStore.lastUpdatedUserValue = null;
  }
}
