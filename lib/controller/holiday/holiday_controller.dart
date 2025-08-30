import 'package:ticky/model/holiday/holiday_response.dart';
import 'package:ticky/utils/config.dart';

import '../../network/api_client.dart';

class HolidayController {
  static Future<HolidayResponse> getHolidayListApi() async {
    return HolidayResponse.fromJson(await handleResponse(await buildHttpResponse(HolidayEndPoints.getHolidayListUrl)));
  }
}
