import 'dart:io';

import 'package:ag_widgets/extension/list_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/auth/auth_api_controller.dart';
import 'package:ticky/controller/engineer/personal_details/persoanl_detail_controller.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/auth/timezone_response.dart';
import 'package:ticky/model/auth/user_data.dart';
import 'package:ticky/model/engineer/master_data_response.dart';
import 'package:ticky/utils/config.dart';

part 'personal_details_store.g.dart';

class PersonalDetailsStore = PersonalDetailsStoreBase with _$PersonalDetailsStore;

abstract class PersonalDetailsStoreBase with Store {
  Future<void> init() async {
    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.personalDataApiState, value: true);

    firstNameCont.text = userStore.firstName.validate();
    lastNameCont.text = userStore.lastName.validate();
    emailNameCont.text = userStore.email.validate();
    phoneNumberCont.text = userStore.phoneNumber.validate();

    await PersonalDetailController.getUserDataApi().then((data) {
      if (data.alternativeContact != null) alternateNumberCont.text = data.alternativeContact.validate();
      if (data.birthdate != null) {
        birthDate = DateTime.parse(data.birthdate.validate());
        birthDateCont.text = DateFormat(ShowDateFormat.ddMmmYyyy).format(birthDate!).toString();
      }
      if (data.address != null) {
        apartmentCont.text = data.address!.apartment.validate();
        address1Cont.text = data.address!.addressLine1.validate();
        address2Cont.text = data.address!.addressLine2.validate();
        cityCont.text = data.address!.city.validate();
        countryCont.text = data.address!.country.validate();
        zipCodeCont.text = data.address!.zipcode.validate();
      }

      addressCont.text = data.addressText.validate();

      if (data.gender != null) selectedGenderData = MasterData(value: data.gender.validate(), label: data.gender.validate().capitalizeFirstLetter());

      if (data.countryCode.validate().isNotEmpty) {
        countryCode = data.countryCode.validate().contains("+") ? data.countryCode.validate() : "+" + data.countryCode.validate();
      }
      if (data.contactIso.validate().isNotEmpty) {
        contactIso = data.contactIso.validate();
      }
      if (data.alternateContactIso.validate().isNotEmpty) {
        alternateContactIso = data.alternateContactIso.validate();
      }
      if (data.contactIso.validate().isNotEmpty && data.alternateContactIso.validate().isEmpty) {
        alternateContactIso = data.contactIso.validate();
      }
      if (data.alternateCountryCode.validate().isNotEmpty) {
        altCountryCode = data.alternateCountryCode.validate().contains("+") ? data.alternateCountryCode.validate() : "+" + data.alternateCountryCode.validate();
      }

      userStore.setEmailVerified(data.emailVerification.getBoolInt());
      userStore.setPhoneNumberVerified(data.phoneVerification.getBoolInt());
      getTimezone(data: data);

      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.personalDataApiState, value: false);
    });
  }

  @action
  void getTimezone({User? data}) {
    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.timezoneApiState, value: true);
    AuthApiController.getCountryWiseTimezoneApi(phoneCode: countryCode.validate(), isoCode: contactIso.validate()).then((value) {
      signupStore.setTimezoneList(value.zone);
      if (data != null) {
        Timezones selectedValue = value.zone!.timezones.validate().firstWhere(
          (element) => element.zoneName.validate() == data.timezone.validate(),
          orElse: () {
            return Timezones();
          },
        );
        signupStore.setTimezone(selectedValue);
      } else {
        signupStore.setTimezoneList(value.zone);

        if (value.zone!.timezones.validate().isSingle) {
          signupStore.setTimezone(value.zone!.timezones!.first);
        }
      }

      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.timezoneApiState, value: false);
    });
  }

  @observable
  TextEditingController firstNameCont = TextEditingController();

  @observable
  TextEditingController lastNameCont = TextEditingController();

  @observable
  TextEditingController emailNameCont = TextEditingController();

  @observable
  TextEditingController phoneNumberCont = TextEditingController();

  @observable
  String countryCode = "+91";

  @observable
  String contactIso = "IN";

  @observable
  String altCountryCode = "+91";

  @observable
  String alternateContactIso = "";

  @observable
  TextEditingController alternateNumberCont = TextEditingController();

  @observable
  TextEditingController birthDateCont = TextEditingController();

  @observable
  TextEditingController apartmentCont = TextEditingController();

  @observable
  TextEditingController address1Cont = TextEditingController();

  @observable
  TextEditingController address2Cont = TextEditingController();

  @observable
  TextEditingController cityCont = TextEditingController();

  @observable
  TextEditingController countryCont = TextEditingController();

  @observable
  TextEditingController zipCodeCont = TextEditingController();

  @observable
  DateTime? birthDate;

  @observable
  MasterDataResponse? genderInitialData;

  @observable
  MasterData? selectedGenderData;

  @observable
  TextEditingController addressCont = TextEditingController();

  @observable
  GlobalKey<FormState> addressFormState = GlobalKey();

  @observable
  FocusNode firstNameFocusNode = FocusNode();

  @observable
  FocusNode lastNameFocusNode = FocusNode();

  @observable
  FocusNode phoneNumberFocusNode = FocusNode();

  @observable
  FocusNode alternateNumberFocusNode = FocusNode();

  @observable
  FocusNode apartmentFocusNode = FocusNode();

  @observable
  FocusNode apartmentOneFocusNode = FocusNode();

  @observable
  FocusNode apartmentTwoFocusNode = FocusNode();

  @observable
  FocusNode zipCodeFocusNode = FocusNode();

  @observable
  FocusNode cityFocusNode = FocusNode();

  @observable
  FocusNode countryFocusNode = FocusNode();

  Future<Map<String, dynamic>> createJson() async {
    User tempUserData = User();
    Address tempAddress = Address();

    tempUserData.id = userStore.userId;
    tempUserData.email = emailNameCont.text.trim();
    tempUserData.firstName = firstNameCont.text.trim();
    tempUserData.lastName = lastNameCont.text.trim();

    tempUserData.contact = phoneNumberCont.text.replaceAll("+", "").trim();
    tempUserData.countryCode = countryCode.replaceAll("+", "").trim();

    tempUserData.contactIso = contactIso;
    tempUserData.alternateContactIso = alternateContactIso;
    tempUserData.timezone = signupStore.selectedTimeZone!.zoneName.validate();

    tempUserData.alternativeContact = alternateNumberCont.text.replaceAll("+", "").trim();
    tempUserData.alternateCountryCode = altCountryCode.replaceAll("+", "").trim();

    if (birthDate != null) {
      tempUserData.birthdate = DateFormat(ShowDateFormat.yyyyMmDdDash).format(birthDate!);
    }

    tempAddress.apartment = apartmentCont.text.validate();
    tempAddress.addressLine1 = address1Cont.text.validate();
    tempAddress.addressLine2 = address2Cont.text.validate();
    tempAddress.city = cityCont.text.validate();
    tempAddress.country = countryCont.text.validate();
    tempAddress.zipcode = zipCodeCont.text.validate();

    tempUserData.address = tempAddress;

    if (selectedGenderData != null) {
      tempUserData.gender = selectedGenderData!.value.validate();
    }

    return tempUserData.toJson();
  }

  @action
  void setGender(MasterData value) {
    selectedGenderData = value;
  }

  @observable
  List<File> profilePictureFiles = ObservableList();

  @action
  Future<void> setProfilePictureFiles({required List<File> file}) async {
    profilePictureFiles = file;
  }

  @action
  Future<void> onSubmit() async {
    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.personalDataApiState, value: true);

    Map<String, dynamic> request = await createJson();

    await PersonalDetailController.addPersonalDetailApi(request: request).then((res) {
      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.personalDataApiState, value: false);
      toast(res.message.validate());

      finish(getContext);
    }).catchError((e) {
      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.personalDataApiState, value: false);
      toast(e.toString(), print: true);
    });
  }

  @action
  Future<void> onProfileSubmit() async {
    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.personalDataApiState, value: true);

    await PersonalDetailController.updateProfilePictureApi(files: profilePictureFiles).then((res) {
      userStore.setPhoneNumberVerified(true);
      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.personalDataApiState, value: false);
    }).catchError((e) {
      personalDetailsStore.setProfilePictureFiles(file: []);
      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.personalDataApiState, value: false);
    });
  }

  @action
  Future<void> onMobileVerificationSubmit(bool value) async {
    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.personalDataApiState, value: true);

    await PersonalDetailController.updateMobileVerifiedApi(value: value.getIntBool()).then((res) {
      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.personalDataApiState, value: false);
    }).catchError((e) {
      personalDetailsStore.setProfilePictureFiles(file: []);
      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.personalDataApiState, value: false);
    });
  }

  @action
  Future<void> onGDPRConsentSubmit(bool value) async {
    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.gdprConsentApiState, value: true);

    await PersonalDetailController.updateGdprConsentApi(value: value.getIntBool()).then((res) {
      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.gdprConsentApiState, value: false);
      finish(getContext);
    }).catchError((e) {
      personalDetailsStore.setProfilePictureFiles(file: []);
      appLoaderStore.setLoaderValue(appState: AppLoaderStateName.gdprConsentApiState, value: false);
    });
  }

  Future<void> dispose() async {
    firstNameCont.clear();
    lastNameCont.clear();
    emailNameCont.clear();
    phoneNumberCont.clear();
    alternateNumberCont.clear();
    birthDateCont.clear();
    addressCont.clear();
    birthDate = null;
    selectedGenderData = null;
  }
}
