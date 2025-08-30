import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/dashboard/dashboard_response.dart';
import 'package:ticky/network/api_client.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/view/tickets/background_location_service.dart';

class DashboardController {
  static Future<DashboardResponse> getDashboardApi() async {
    var res = DashboardResponse.fromJson(await handleResponse(await buildHttpResponse(DashboardEndPoints.getDashboardUrl + "/${userStore.userId}")));

    dashboardStore.dashboardResponseInitialData = res;
    if (res.dashboardData != null && res.dashboardData!.dashboard != null && res.dashboardData!.dashboard!.tickets.validate().isNotEmpty) {
      if (res.dashboardData!.dashboard!.tickets!.any((element) => element.isProgress())) {
        backgroundLocationService.startTracking(res.dashboardData!.dashboard!.tickets!.firstWhere((element) => element.isProgress()));
      }
    }

    return res;
  }
}
