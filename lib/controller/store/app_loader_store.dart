import 'package:mobx/mobx.dart';

part 'app_loader_store.g.dart';

class AppLoaderStore = AppLoaderStoreBase with _$AppLoaderStore;

abstract class AppLoaderStoreBase with Store {
  @observable
  ObservableMap<String, bool> appLoadingState = ObservableMap.of(
    {
      AppLoaderStateName.loginApiState: false,
      AppLoaderStateName.signUpApiState: false,
      AppLoaderStateName.forgotPasswordApiState: false,
      AppLoaderStateName.personalDataApiState: false,
      AppLoaderStateName.addEducationApiState: false,
      AppLoaderStateName.addSpokenLanguageApiState: false,
      AppLoaderStateName.addTechnicalSkillApiState: false,
      AppLoaderStateName.addIndustryExperienceApiState: false,
      AppLoaderStateName.travelDetailApiState: false,
      AppLoaderStateName.paymentDetailApiState: false,
      AppLoaderStateName.documentApiState: false,
      AppLoaderStateName.ticketRejectedStatusApiState: false,
      AppLoaderStateName.ticketAcceptedStatusApiState: false,
      AppLoaderStateName.startWorkApiState: false,
      AppLoaderStateName.ticketsNotesApiState: false,
      AppLoaderStateName.mobileOtpApiState: false,
      AppLoaderStateName.calendarApiState: false,
      AppLoaderStateName.setYesForTaskReminderApiState: false,
      AppLoaderStateName.setNoForTaskReminderApiState: false,
      AppLoaderStateName.setLogOutApiState: false,
      AppLoaderStateName.holidayApiState: false,
    },
  );

  @action
  bool setLoaderValue({required String appState, required bool value}) {
    return appLoadingState[appState] = value;
  }
}

class AppLoaderStateName {
  static String loginApiState = "loginApiState";
  static String signUpApiState = "signUpApiState";
  static String countryCodeApiState = "countryCodeApiState";
  static String timezoneApiState = "timezoneApiState";
  static String skipAndLoginApiState = "skipAndLoginApiState";
  static String forgotPasswordApiState = "forgotPasswordApiState";
  static String resetPasswordApiState = "resetPasswordApiState";
  static String changePasswordApiState = "changePasswordApiState";
  static String holidayApiState = "holidayApiState";

  static String deleteAccountApiState = "deleteAccountApiState";
  static String personalDataApiState = "personalDataApiState";
  static String addEducationApiState = "addEducationApiState";
  static String applyLeaveApiState = "applyLeaveApiState";
  static String addSpokenLanguageApiState = "addSpokenLanguageApiState";
  static String addTechnicalSkillApiState = "addTechnicalSkillApiState";
  static String addTechnicalCertificateApiState = "addTechnicalCertificateApiState";
  static String addIndustryExperienceApiState = "addIndustryExperienceApiState";
  static String travelDetailApiState = "travelDetailApiState";
  static String paymentDetailApiState = "paymentDetailApiState";
  static String documentApiState = "documentApiState";
  static String ticketRejectedStatusApiState = "ticketRejectedStatusApiState";
  static String ticketAcceptedStatusApiState = "ticketAcceptedStatusApiState";
  static String breakApiState = "breakApiState";
  static String startWorkApiState = "startWorkApiState";
  static String ticketsNotesApiState = "ticketsNotesApiState";
  static String foodExpenseApiState = "foodExpenseApiState";
  static String rightToWorkApiState = "rightToWorkApiState";
  static String mobileOtpApiState = "mobileOtpApiState";

  static String calendarApiState = "calendarApiState";
  static String gdprConsentApiState = "gdprConsentApiState";

  static String setYesForTaskReminderApiState = "setYesForTaskReminderApiState";
  static String setNoForTaskReminderApiState = "setNoForTaskReminderApiState";

  static String setLogOutApiState = "setLogOutApiState";
}
