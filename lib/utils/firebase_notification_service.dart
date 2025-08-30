import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/auth/auth_api_controller.dart';
import 'package:ticky/firebase_options.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/notification/notification_const.dart';
import 'package:ticky/model/tickets/ticket_data.dart';
import 'package:ticky/utils/enums.dart';
import 'package:ticky/view/setting/widget/notification_screen.dart';
import 'package:ticky/view/tickets/tickets_detail_screen.dart';

import '../model/notification/notification_response.dart' hide NotificationResponse;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  debugPrint("🔥 Background Message Received: ${message.toMap()}");
}

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  Map<String, dynamic> _localNotificationPayload = {};

  /// Initialize Firebase Messaging & Local Notifications
  Future<void> initialise() async {
    await requestPermission();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await _initializeLocalNotifications();

    final token = await _fcm.getToken().catchError(onError);
    userStore.setFirebaseToken(token.validate());

    await _fcm.onTokenRefresh.listen(
      (updatedToken) async {
        if (userStore.firebaseToken.validate().isNotEmpty && updatedToken.isNotEmpty && userStore.firebaseToken.validate() != updatedToken) {
          await AuthApiController.updateTokenApi(token: updatedToken).then((value) {
            userStore.setFirebaseToken(token.validate());
          }).catchError(onError);
        }
      },
    );

    FirebaseMessaging.onMessage.listen((event) {
      debugPrint("📩 Foreground Message Received: ${event.toMap()}");
      _handleNotification(event, localNotification: true);
    });

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);
  }

  /// Request permission for notifications
  Future<void> requestPermission() async {
    final settings = await _fcm.requestPermission(alert: true, badge: true, sound: true);

    await _fcm.setForegroundNotificationPresentationOptions(sound: true, alert: true, badge: true);

    debugPrint(settings.authorizationStatus == AuthorizationStatus.authorized ? "🔔 Notification permission granted" : "🚫 Notification permission denied");
  }

  /// Initialize local notifications
  Future<void> _initializeLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();

    final initSettings = InitializationSettings(android: androidSettings, iOS: iosSettings);

    await localNotifications.initialize(initSettings, onDidReceiveNotificationResponse: _selectNotification);
  }

  /// Handle notifications in the foreground
  Future<void> _handleNotification(RemoteMessage message, {bool localNotification = false}) async {
    if (!localNotification || message.notification == null || message.data['break'] != null) return;

    final sent = message.sentTime?.toString();
    if (sent != null && sent != sentTime) {
      _localNotificationPayload = message.data;
      sentTime = sent;

      mainLog(message: jsonEncode(message.data), label: 'message.data => ');

      const androidDetails = AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        channelDescription: 'Channel for important notifications',
        importance: Importance.max,
        priority: Priority.high,
      );

      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      var notificationDetails = NotificationDetails(android: androidDetails, iOS: iosDetails);

      await localNotifications.show(
        0,
        message.notification?.title ?? 'No Title',
        message.notification?.body ?? 'No Body',
        notificationDetails,
      );
    }
  }

  /// Handle when notification is tapped
  Future<void> _selectNotification(NotificationResponse response) async {
    if (_localNotificationPayload.isNotEmpty) {
      if (response.payload != null && response.payload!.isNotEmpty) {
        mainLog(
          message: response.payload!,
          label: 'response.payload => ',
        );
      }
      await _manageRedirection(_localNotificationPayload);
    }
  }

  /// Handle app being opened from a terminated state via a notification
  Future<void> onKillRedirection() async {
    final message = await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      debugPrint("📂 App Opened from Terminated State: ${message.data}");
      await Future.delayed(const Duration(seconds: 2));
      _manageRedirection(message.data);
    }
  }

  /// Handle navigation when notification is tapped
  void _handleMessageOpenedApp(RemoteMessage message) async {
    if (getContext != null) {
      if (ticketListGlobalKey.currentContext == null) {
        dashboardStore.bottomNavigationCurrentIndex = 1;
      }
      // if (dashboardGlobalKey.currentContext == null && calenderGlobalKey.currentContext == null && settingGlobalKey.currentContext != null) {
      await Future.delayed(const Duration(milliseconds: 500));
      await _manageRedirection(message.data);
      // }
    }
  }

  /// Redirect user based on notification data
  Future<void> _manageRedirection(Map<String, dynamic> data) async {
    debugPrint("🔄 Managing Redirection with Data: $data");

    final screen = data['screen'];
    if (screen != null) {
      debugPrint("📌 Navigating to Screen: $screen");
      // Add actual navigation logic here
    } else {
      if (data['notify_type'] == NotificationConstant.workReminderToEngineer) {
        NotificationData notification = NotificationData(responseAdditionalData: ResponseAdditionalData.fromJson(data));

        ///  1. Dialog for Yes or No
        ///  2. If Yes, then do nothing (only read the notification) "EEEE"
        ///  3. If no, then have a reason dialog and accept the reason and send the notification to admin.

        showTicketReminderDialog(getContext, notification: notification);
      } else if (data['notify_type'] == NotificationConstant.offeredTicketsReminders) {
        dashboardStore.setBottomNavigationCurrentIndex(1);
        ticketStore.setCurrentStatusIndex(0);
      } else {
        toast("Else");
      }
    }
  }
}
