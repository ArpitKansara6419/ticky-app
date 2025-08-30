import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/notification/notification_controller.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/notification/notification_const.dart';
import 'package:ticky/model/notification/notification_response.dart';
import 'package:ticky/model/notification/task_reminder.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/utils/widgets/common_app_bar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<NotificationResponse> _notificationFuture;
  List<NotificationData> _notificationList = [];

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  void _loadNotifications() {
    _notificationFuture = NotificationController.notificationApi();
  }

  void _markAllAsRead() {
    setState(() {
      _notificationList = _notificationList.map((n) => n..isSeen = 1).toList();
    });

    toast("All notifications marked as read");

    // TODO: Call backend to mark all as read if supported
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget(
        "Notifications",
        actions: [
          TextButton(
            onPressed: _markAllAsRead,
            child: Text("Mark all as read", style: secondaryTextStyle()),
          ),
        ],
      ),
      body: FutureBuilder<NotificationResponse>(
        future: _notificationFuture,
        builder: (context, snap) {
          if (snap.hasData) {
            _notificationList = snap.data!.notificationData ?? [];

            if (_notificationList.isEmpty) {
              return Center(child: Text("No notifications", style: secondaryTextStyle()));
            }

            return AnimatedListView(
              padding: EdgeInsets.all(16),
              itemCount: _notificationList.length,
              itemBuilder: (context, index) {
                final notification = _notificationList[index];

                return Container(
                  margin: EdgeInsets.only(top: 6, bottom: 6),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: notification.isSeen == 1
                        ? context.cardColor
                        : context.primaryColor.withAlpha(
                            (255 * 0.1).toInt(),
                          ),
                    borderRadius: radius(),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notification.title.validate(), style: boldTextStyle(size: 14)),
                      2.height,
                      Text(notification.body.validate(), style: secondaryTextStyle(size: 12)),
                      2.height,
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(DateTime.parse(notification.createdAt.validate()).timeAgo, style: boldTextStyle(size: 10)),
                      ),
                      /* 2.height,
                      Text(notification.body.validate(), style: secondaryTextStyle(size: 12)),*/
                    ],
                  ),
                ).onTap(() {
                  if (notification.notificationType.validate() == NotificationConstant.workReminderToEngineer) {
                    ///  1. Dialog for Yes or No
                    ///  2. If Yes, then do nothing (only read the notification) "EEEE"
                    ///  3. If no, then have a reason dialog and accept the reason and send the notification to admin.

                    showTicketReminderDialog(context, notification: notification);
                  } else if (notification.notificationType.validate() == NotificationConstant.offeredTicketsReminders) {
                    toast("offeredTicketsReminders");
                  } else {
                    toast("Else");
                  }
                });
              },
            );
          }

          return snapWidgetHelper(snap);
        },
      ),
    );
  }
}

Future<void> showTicketReminderDialog(BuildContext context, {required NotificationData notification}) async {
  // bool? isAvailable;
  // TextEditingController reasonController = TextEditingController();
  // TextEditingController etaController = TextEditingController();

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => Platform.isIOS
        ? CupertinoAlertDialog(
            title: Offstage(),
            content: buildDIalogContent(notification),
            actions: [
              Observer(
                builder: (context) => CupertinoDialogAction(
                  onPressed: () async {
                    // isAvailable = true;
                    appLoaderStore.setLoaderValue(
                      appState: AppLoaderStateName.setYesForTaskReminderApiState,
                      value: true,
                    );
                    // await Future.delayed(Duration(seconds: 2));
                    await NotificationController.taskReminderUpdateApi(
                      request: TaskReminderRequest(
                        userResponse: 'Yes',
                        reason: 'Yes will reach time',
                      ),
                      taskReminderID: notification.responseAdditionalData != null && notification.responseAdditionalData!.taskID != null && notification.responseAdditionalData!.taskID!.isNotEmpty
                          ? notification.responseAdditionalData!.taskID!
                          : '0',
                    );
                    appLoaderStore.setLoaderValue(
                      appState: AppLoaderStateName.setYesForTaskReminderApiState,
                      value: false,
                    );
                    Navigator.pop(ctx);
                  },
                  child: appLoaderStore.appLoadingState[AppLoaderStateName.setYesForTaskReminderApiState].validate()
                      ? SizedBox(
                          width: 15,
                          height: 15,
                          child: CircularProgressIndicator(
                            color: Colors.black,
                            strokeWidth: 1.5,
                          ),
                        )
                      : const Text("Yes"),
                ),
              ),
              CupertinoDialogAction(
                onPressed: () async {
                  // isAvailable = false;
                  Navigator.pop(ctx);
                  await Future.delayed(Duration(milliseconds: 750));
                  await showBottomSheetWithReason(context, notification: notification);
                },
                child: const Text("No"),
              ),
            ],
          )
        : Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildDIalogContent(notification),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppButton(
                        // width: context.width(),
                        onTap: () async {
                          // setState(() {
                          //   isAvailable = false;
                          // });
                          // appLoaderStore.setLoaderValue(
                          //   appState: AppLoaderStateName.setNoForTaskReminderApiState,
                          //   value: true,
                          // );
                          // await Future.delayed(Duration(seconds: 3));
                          //
                          // appLoaderStore.setLoaderValue(
                          //   appState: AppLoaderStateName.setNoForTaskReminderApiState,
                          //   value: false,
                          // );
                          Navigator.pop(context);
                          // finish(context);
                          // showDialog(
                          //     context: context,
                          //     builder: (BuildContext context) {
                          //       return Column(
                          //         mainAxisSize: MainAxisSize.min,
                          //         children: [
                          //           Text("Ticket ID: ${notification.responseAdditionalData!.ticketCode}", style: primaryTextStyle(size: 14)),
                          //         ],
                          //       );
                          //     });

                          await Future.delayed(Duration(milliseconds: 750));
                          await showBottomSheetWithReason(context, notification: notification);
                        },
                        text: "No, I may be delayed",
                        color: context.theme.colorScheme.error,
                        textColor: context.theme.colorScheme.onError,
                      ).expand(),
                      // if (appLoaderStore.appLoadingState[AppLoaderStateName.setNoForTaskReminderApiState].validate()) ...[
                      //   18.width,
                      //   SizedBox(
                      //     width: 15,
                      //     height: 15,
                      //     child: CircularProgressIndicator(
                      //       color: Colors.black,
                      //       strokeWidth: 2,
                      //     ),
                      //   ),
                      // ],
                    ],
                  ),
                  16.height,
                  Observer(
                    builder: (context) => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppButton(
                          // width: context.width(),
                          onTap: () async {
                            // isAvailable = true;
                            appLoaderStore.setLoaderValue(
                              appState: AppLoaderStateName.setYesForTaskReminderApiState,
                              value: true,
                            );
                            await Future.delayed(Duration(seconds: 3));
                            // await NotificationController.taskReminderUpdateApi(
                            //   request: TaskReminderRequest(
                            //     userResponse: 'Yes',
                            //     reason: 'Yes will reach time',
                            //   ),
                            //   taskReminderID: notification.responseAdditionalData != null && notification.responseAdditionalData!.taskID != null && notification.responseAdditionalData!.taskID!.isNotEmpty
                            //       ? notification.responseAdditionalData!.taskID!
                            //       : '0',
                            // );
                            appLoaderStore.setLoaderValue(
                              appState: AppLoaderStateName.setYesForTaskReminderApiState,
                              value: false,
                            );
                            Navigator.pop(ctx);
                          },
                          text: "Yes, I’ll be there on time",
                          color: context.theme.colorScheme.primaryContainer,
                          textColor: context.theme.colorScheme.primary,
                        ).expand(),
                        if (appLoaderStore.appLoadingState[AppLoaderStateName.setYesForTaskReminderApiState].validate()) ...[
                          18.width,
                          SizedBox(
                            width: 15,
                            height: 15,
                            child: CircularProgressIndicator(
                              color: Colors.black,
                              strokeWidth: 2,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  // if (isAvailable == false) ...[
                  //   const SizedBox(height: 16),
                  //   TitleFormComponent(
                  //     text: 'Reason'
                  //         '',
                  //     child: AppTextField(
                  //       textFieldType: TextFieldType.MULTILINE,
                  //       controller: reasonController,
                  //       decoration: inputDecoration(),
                  //     ),
                  //   ),
                  //   const SizedBox(height: 12),
                  //   AppButton(
                  //     onTap: () {
                  //       Navigator.pop(context);
                  //     },
                  //     text: "Submit",
                  //   ),
                  // ],
                ],
              ),
            ),
          ),
  );
}

Column buildDIalogContent(NotificationData notification) {
  return Column(
    children: [
      Text("Ticket Reminder".toUpperCase(), style: boldTextStyle(size: 24)),
      4.height,
      Text("Ticket ID: ${notification.responseAdditionalData!.ticketCode}", style: primaryTextStyle(size: 14)),
      8.height,
      Divider(),
      16.height,
      Text(
          "You have been assigned a task under ticket ${notification.responseAdditionalData!.ticketCode}. Please confirm if you'll be able to reach the assigned location on time as per the scheduled plan."),
      16.height,
      Text("Timely arrival ensures smooth workflow and efficient task execution."),
      32.height,
    ],
  );
}

Future<void> showBottomSheetWithReason(BuildContext context, {required NotificationData notification}) async {
  final TextEditingController reasonController = TextEditingController();

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    useRootNavigator: true,
    builder: (context) => Container(
      padding: EdgeInsets.only(
        left: 25,
        right: 25,
        bottom: MediaQuery.of(context).viewInsets.bottom + 40,
        // top: 10,
      ),
      child: StatefulBuilder(
        builder: (context, setState) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Reason for Deny Ticket",
              style: secondaryTextStyle(color: Colors.black, size: 16, weight: FontWeight.w700),
            ),
            18.height,
            Divider(
              height: 1,
              thickness: 0.5,
              color: Colors.black.withAlpha(
                (255 * 0.15).toInt(),
              ),
            ),
            30.height,
            AppTextField(
              textFieldType: TextFieldType.MULTILINE,
              controller: reasonController,
              maxLines: 5,
              decoration: inputDecoration(hint: 'Reason...'),
              isValidationRequired: true,
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  return "";
                } else {
                  return "Reason is required";
                }
              },
            ),
            24.height,
            Observer(
              builder: (context) => GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () async {
                  setState(() {});
                  if (reasonController.text.isNotEmpty) {
                    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.setNoForTaskReminderApiState, value: true);
                    // await Future.delayed(Duration(seconds: 1));
                    await NotificationController.taskReminderUpdateApi(
                      request: TaskReminderRequest(
                        userResponse: 'No',
                        reason: reasonController.text,
                      ),
                      taskReminderID: notification.responseAdditionalData != null && notification.responseAdditionalData!.taskID != null && notification.responseAdditionalData!.taskID!.isNotEmpty
                          ? notification.responseAdditionalData!.taskID!
                          : '0',
                    );
                    appLoaderStore.setLoaderValue(appState: AppLoaderStateName.setNoForTaskReminderApiState, value: false);
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                  ),
                  child: appLoaderStore.appLoadingState[AppLoaderStateName.setNoForTaskReminderApiState].validate()
                      ? SizedBox(
                          width: 15,
                          height: 15,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 1.5,
                          ),
                        )
                      : Text(
                          'Continue',
                          style: secondaryTextStyle(
                            weight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
