import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/engineer/technical_skill/add_technical_skills_response.dart';
import 'package:ticky/model/engineer/technical_skill/technical_skills_response.dart';
import 'package:ticky/network/api_client.dart';
import 'package:ticky/utils/config.dart';

class TechnicalSkillController {
  static Future<TechnicalSkillResponse> getTechnicalSkillListApi() async {
    var res = TechnicalSkillResponse.fromJson(await handleResponse(await buildHttpResponse(TechnicalSkillEndPoints.technicalSkillListUrl + "/${userStore.userId}")));

    technicalSkillStore.cachedTechnicalSkillResponse = res;

    return res;
  }

  static Future<AddTechnicalSkillResponse> addTechnicalSkillApi({required Map<String, dynamic> request}) async {
    log("Request $request");
    AddTechnicalSkillResponse res =
        AddTechnicalSkillResponse.fromJson(await handleResponse(await buildHttpResponse(TechnicalSkillEndPoints.saveTechnicalSkillUrl, request: request, method: HttpMethod.POST)));
    return res;
  }

  static Future<AddTechnicalSkillResponse> deleteTechnicalSkillApi({required int id}) async {
    AddTechnicalSkillResponse res =
        AddTechnicalSkillResponse.fromJson(await handleResponse(await buildHttpResponse(TechnicalSkillEndPoints.deleteTechnicalSkillURl + "?id=$id", method: HttpMethod.POST)));
    return res;
  }
}
