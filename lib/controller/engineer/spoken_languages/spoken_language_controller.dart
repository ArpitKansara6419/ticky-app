import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/engineer/spoken_languages/add_spoken_language_response.dart';
import 'package:ticky/model/engineer/spoken_languages/spoken_language_response.dart';
import 'package:ticky/network/api_client.dart';
import 'package:ticky/utils/config.dart';

class SpokenLanguageController {
  static Future<SpokenLanguageResponse> getSpokenLanguageListApi() async {
    var res = SpokenLanguageResponse.fromJson(await handleResponse(await buildHttpResponse(SpokenLanguageEndPoints.spokenLanguageListUrl + "/${userStore.userId}")));

    spokenLanguageStore.cachedSpokenLanguageResponse = res;

    return res;
  }

  static Future<AddSpokenLanguageResponse> addSpokenLanguageApi({required Map<String, dynamic> request}) async {
    log("Request $request");
    AddSpokenLanguageResponse res =
        AddSpokenLanguageResponse.fromJson(await handleResponse(await buildHttpResponse(SpokenLanguageEndPoints.saveSpokenLanguageUrl, request: request, method: HttpMethod.POST)));
    return res;
  }

  static Future<AddSpokenLanguageResponse> deleteSpokenLanguageApi({required int id}) async {
    AddSpokenLanguageResponse res =
        AddSpokenLanguageResponse.fromJson(await handleResponse(await buildHttpResponse(SpokenLanguageEndPoints.deleteSpokenLanguageURl + "?id=$id", method: HttpMethod.POST)));
    return res;
  }
}
