import 'package:intl/intl.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/attendance/attendance_response.dart';
import 'package:ticky/network/api_client.dart';
import 'package:ticky/utils/config.dart';

class AttendanceController {
  static Future<AttendanceResponse> getAttendanceApi({required DateTime date}) async {
    return AttendanceResponse.fromJson(
        await handleResponse(await buildHttpResponse(AttendanceEndPoints.getAttendanceUrl + "/${userStore.userId}" + "/${DateFormat(ShowDateFormat.yyyyMmDdDash).format(date)}")));
  }
}
