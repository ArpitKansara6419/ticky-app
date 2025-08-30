import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/engineer/industry_exp/add_industry_experience_response.dart';
import 'package:ticky/model/engineer/industry_exp/industry_experience_response.dart';
import 'package:ticky/network/api_client.dart';
import 'package:ticky/utils/config.dart';

class IndustryExperienceController {
  static Future<IndustryExperienceResponse> getIndustryExperienceListApi() async {
    var res = IndustryExperienceResponse.fromJson(await handleResponse(await buildHttpResponse(IndustryExperienceEndPoints.industryExperienceListUrl + "/${userStore.userId}")));

    industryExperienceStore.cachedIndustryExperienceResponse = res;

    return res;
  }

  static Future<AddIndustryExperienceResponse> addIndustryExperienceApi({required Map<String, dynamic> request}) async {
    log("Request $request");
    AddIndustryExperienceResponse res =
        AddIndustryExperienceResponse.fromJson(await handleResponse(await buildHttpResponse(IndustryExperienceEndPoints.saveIndustryExperienceUrl, request: request, method: HttpMethod.POST)));
    return res;
  }

  static Future<AddIndustryExperienceResponse> deleteIndustryExperienceApi({required int id}) async {
    AddIndustryExperienceResponse res =
        AddIndustryExperienceResponse.fromJson(await handleResponse(await buildHttpResponse(IndustryExperienceEndPoints.deleteIndustryExperienceURl + "?id=$id", method: HttpMethod.POST)));
    return res;
  }
}
