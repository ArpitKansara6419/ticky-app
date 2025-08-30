import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/engineer/travel_details/add_travel_detail_response.dart';
import 'package:ticky/model/engineer/travel_details/travel_details_response.dart';
import 'package:ticky/network/api_client.dart';
import 'package:ticky/utils/config.dart';

class TravelController {
  static Future<TravelDetailsResponse?> getTravelDetailListApi() async {
    TravelDetailsResponse? res = TravelDetailsResponse.fromJson(await handleResponse(await buildHttpResponse(TravelDetailsEndPoints.travelDetailsListUrl + "/${userStore.userId}")));

    travelDetailsStore.cachedTravelDetailResponse = res;

    return res;
  }

  static Future<AddTravelDetailsResponse> addTravelDetailApi({required Map<String, dynamic> request}) async {
    log("Request $request");
    AddTravelDetailsResponse res =
        AddTravelDetailsResponse.fromJson(await handleResponse(await buildHttpResponse(TravelDetailsEndPoints.saveTravelDetailsUrl, request: request, method: HttpMethod.POST)));
    return res;
  }

  static Future<AddTravelDetailsResponse> deleteTravelDetailApi({required int id}) async {
    AddTravelDetailsResponse res = AddTravelDetailsResponse.fromJson(await handleResponse(await buildHttpResponse(TravelDetailsEndPoints.deleteTravelDetailsURl + "$id", method: HttpMethod.POST)));
    return res;
  }
}
