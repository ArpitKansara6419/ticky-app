import 'package:ticky/controller/auth/auth_api_controller.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/engineer/master_data_response.dart';
import 'package:ticky/network/api_client.dart';
import 'package:ticky/utils/config.dart';

class MasterDataController {
  /// Fetches all master data concurrently using isolates.
  static Future<void> fetchAllData({bool isSaveDetail = false}) async {
    // Define a list of tasks to run in parallel
    List<Future<void>> tasks = [
      /*     getVehicleListApi(),
      getIndustryExpListApi(),
      getTechnicalListApi(),
      getTechnicalCertificationListApi(),
      getTechnicalSkillsLevelListApi(),
      getSpokenLanguagesListApi(),
      getSpokenLanguageLevelListApi(),
      getSpokenLanguageProficiencyListApi(),
      getGenderListApi(),
      getRightToWorkListApi(),
      getIndustryLevelListApi(),*/
      AuthApiController.getUserDetailApi(isSaveDetail: isSaveDetail, isCheckToken: true),
      AuthApiController.getProfileCompletionApi(),
    ];

    // Wait for all tasks to complete
    await Future.wait(tasks);
    print("All data fetched successfully!");
  }

  static Future<MasterDataResponse> getVehicleListApi() async {
    MasterDataResponse res = MasterDataResponse.fromJson(await handleResponse(await buildHttpResponse(MasterDataEndPoints.vehicleType)));

    travelDetailsStore.vehicleListMetaData = res;
    return res;
  }

  static Future<MasterDataResponse> getIndustryExpListApi() async {
    MasterDataResponse res = MasterDataResponse.fromJson(await handleResponse(await buildHttpResponse(MasterDataEndPoints.industryType)));

    return res;
  }

  static Future<MasterDataResponse> getTechnicalListApi() async {
    MasterDataResponse res = MasterDataResponse.fromJson(await handleResponse(await buildHttpResponse(MasterDataEndPoints.technicalSkills)));
    technicalSkillStore.skillNameInitialData = res;

    return res;
  }

  static Future<MasterDataResponse> getTechnicalCertificationListApi() async {
    MasterDataResponse res = MasterDataResponse.fromJson(await handleResponse(await buildHttpResponse(MasterDataEndPoints.technicalCertificationSkills)));
    technicalCertificationStore.certificateInitialData = res;

    return res;
  }

  static Future<MasterDataResponse> getTechnicalSkillsLevelListApi() async {
    MasterDataResponse res = MasterDataResponse.fromJson(await handleResponse(await buildHttpResponse(MasterDataEndPoints.technicalSkillsLevel)));

    technicalSkillStore.experienceLevelInitialData = res;
    return res;
  }

  static Future<MasterDataResponse> getSpokenLanguagesListApi() async {
    MasterDataResponse res = MasterDataResponse.fromJson(await handleResponse(await buildHttpResponse(MasterDataEndPoints.spokenLanguages)));

    spokenLanguageStore.spokenLanguageInitialData = res;
    return res;
  }

  static Future<MasterDataResponse> getSpokenLanguageLevelListApi() async {
    MasterDataResponse res = MasterDataResponse.fromJson(await handleResponse(await buildHttpResponse(MasterDataEndPoints.spokenLanguageLevel)));

    spokenLanguageStore.spokenLanguageLevelInitialData = res;
    return res;
  }

  static Future<MasterDataResponse> getSpokenLanguageProficiencyListApi() async {
    MasterDataResponse res = MasterDataResponse.fromJson(await handleResponse(await buildHttpResponse(MasterDataEndPoints.spokenLanguageProficiency)));

    spokenLanguageStore.spokenLanguageProficiencyInitialData = res;
    return res;
  }

  static Future<MasterDataResponse> getIndustryListApi() async {
    MasterDataResponse res = MasterDataResponse.fromJson(await handleResponse(await buildHttpResponse(MasterDataEndPoints.industryType)));

    industryExperienceStore.industryNameInitialData = res;
    return res;
  }

  static Future<MasterDataResponse> getIndustryLevelListApi() async {
    MasterDataResponse res = MasterDataResponse.fromJson(await handleResponse(await buildHttpResponse(MasterDataEndPoints.industryTypeLevel)));

    industryExperienceStore.industryLevelInitialData = res;
    return res;
  }

  static Future<MasterDataResponse> getGenderListApi() async {
    MasterDataResponse res = MasterDataResponse.fromJson(await handleResponse(await buildHttpResponse(MasterDataEndPoints.gender)));

    personalDetailsStore.genderInitialData = res;
    return res;
  }

  static Future<MasterDataResponse> getRightToWorkListApi() async {
    MasterDataResponse res = MasterDataResponse.fromJson(await handleResponse(await buildHttpResponse(MasterDataEndPoints.rightToWork)));

    rightToWorkStore.rightToWorkInitialData = res;
    return res;
  }
}
