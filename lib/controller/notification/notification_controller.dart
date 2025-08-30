import 'package:ticky/model/notification/notification_response.dart';
import 'package:ticky/model/notification/task_reminder.dart';
import 'package:ticky/network/api_client.dart';
import 'package:ticky/utils/config.dart';

class NotificationController {
  static Future<NotificationResponse> notificationApi() async {
    String start = "?start=0";
    String rawPerPage = "&rawperpage=100";

    NotificationResponse res = NotificationResponse.fromJson(await handleResponse(await buildHttpResponse(NotificationEndPoints.notificationApiUrl + start + rawPerPage, method: HttpMethod.GET)));
    return res;
  }

  static Future<TaskReminderResponse> taskReminderUpdateApi({
    required TaskReminderRequest request,
    required String taskReminderID,
  }) async {
    TaskReminderResponse res = TaskReminderResponse.fromJson(
      await handleResponse(
        await buildHttpResponse(
          NotificationEndPoints.taskReminderUpdateUrl + taskReminderID,
          method: HttpMethod.PUT,
          request: request.toJson(),
        ),
      ),
    );
    return res;
  }
}
