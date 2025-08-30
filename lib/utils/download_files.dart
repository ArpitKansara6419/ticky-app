import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class DownloadFileScreen extends StatefulWidget {
  @override
  _DownloadFileScreenState createState() => _DownloadFileScreenState();
}

class _DownloadFileScreenState extends State<DownloadFileScreen> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  void _initializeNotifications() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> downloadFile(String url, String fileName) async {
// Request permission for storage
    /*  if (!await Permission.storage.request().isGranted) {
      return;
    }
*/

    final directory = await getExternalStorageDirectory();
    final filePath = '${directory!.path}/$fileName';

    // Start downloading
    try {
      final request = http.Request('GET', Uri.parse(url));
      final streamedResponse = await request.send();

      if (streamedResponse.statusCode == 200) {
        int receivedBytes = 0;
        final totalBytes = streamedResponse.contentLength ?? 0;

        final file = File(filePath);
        final sink = file.openWrite();

        showProgressNotification(0);

        await for (final chunk in streamedResponse.stream) {
          receivedBytes += chunk.length;
          sink.add(chunk);

          // Update progress notification
          final progress = (receivedBytes / totalBytes * 100).floor();
          showProgressNotification(progress);
        }

        await sink.close();
        showCompletedNotification(filePath);
      } else {
        showErrorNotification();
      }
    } catch (e) {
      showErrorNotification();
    }
  }

  void showProgressNotification(int progress) {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'download_channel',
      'File Downloads',
      channelDescription: 'Notification channel for file downloads',
      importance: Importance.high,
      priority: Priority.high,
      showProgress: true,
      maxProgress: 100,
      playSound: false,
    );

    final NotificationDetails notificationDetails = NotificationDetails(android: androidDetails);

    flutterLocalNotificationsPlugin.show(
      0,
      'Downloading File',
      '$progress% completed',
      notificationDetails,
      payload: null,
    );
  }

  void showCompletedNotification(String filePath) {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'download_channel',
      'File Downloads',
      channelDescription: 'Notification channel for file downloads',
      importance: Importance.high,
      priority: Priority.high,
    );

    final NotificationDetails notificationDetails = NotificationDetails(android: androidDetails);

    flutterLocalNotificationsPlugin.show(
      0,
      'Download Complete',
      'File saved to $filePath',
      notificationDetails,
      payload: filePath,
    );
  }

  void showErrorNotification() {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'download_channel',
      'File Downloads',
      channelDescription: 'Notification channel for file downloads',
      importance: Importance.high,
      priority: Priority.high,
    );

    final NotificationDetails notificationDetails = NotificationDetails(android: androidDetails);

    flutterLocalNotificationsPlugin.show(
      0,
      'Download Failed',
      'Unable to download the file',
      notificationDetails,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Download File with Progress'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            downloadFile(
              'https://example.com/sample.pdf', // Replace with your file URL
              'sample.pdf',
            );
          },
          child: Text('Download File'),
        ),
      ),
    );
  }
}
