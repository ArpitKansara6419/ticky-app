import 'dart:async';

import 'package:ag_widgets/extension/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/dashboard/dashboard_controller.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/dashboard/dashboard_response.dart';
import 'package:ticky/model/location/greeting_with_icon_model.dart';
import 'package:ticky/model/tickets/ticket_data.dart';
import 'package:ticky/utils/enums.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/utils/widgets/amount_display_widget.dart';
import 'package:ticky/utils/widgets/app_loader.dart';
import 'package:ticky/utils/widgets/complete_profile_widget.dart';
import 'package:ticky/view/common_widget.dart';
import 'package:ticky/view/component/header_component.dart';
import 'package:ticky/view/home/widget/dashboard_ticket_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<DashboardResponse>? future;
  final GlobalKey<RefreshIndicatorState> _refreshDashboardIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    dashboardGlobalKey.currentState?.dispose();
    super.dispose();
  }

  void init() async {
    future = DashboardController.getDashboardApi();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  BoxDecoration decoration = BoxDecoration(color: Colors.white, borderRadius: radius(), boxShadow: defaultBoxShadow(blurRadius: 1, spreadRadius: 0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: dashboardGlobalKey,
      appBar: HeaderComponent(name: MenuName.dashboard),
      body: FutureBuilder<DashboardResponse>(
        initialData: dashboardStore.dashboardResponseInitialData,
        future: future,
        builder: (context, snap) {
          if (snap.hasData) {
            if (snap.data!.dashboardData != null) {
              Dashboard data = snap.data!.dashboardData!.dashboard!;
              return RefreshIndicator(
                key: _refreshDashboardIndicatorKey,
                onRefresh: () async {
                  init();
                },
                notificationPredicate: (notification) {
                  return notification.depth == 0;
                },
                color: primaryColor,
                child: AnimatedScrollView(
                  padding: EdgeInsets.only(bottom: 16, right: 16, left: 16),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  listAnimationType: ListAnimationType.None,
                  physics: AlwaysScrollableScrollPhysics(),
                  children: [
                    8.height,
                    Text("${getGreetingWithIconModel().message}, ${userStore.firstName} !", style: boldTextStyle(size: 20, color: context.primaryColor)),
                    16.height,
                    if (data.overview != null)
                      AnimatedWrap(
                        itemCount: 2,
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () async {
                              dashboardStore.setBottomNavigationCurrentIndex(1);
                              mainLog(message: "setBottomNavigationCurrentIndex");
                              await Future.delayed(Duration(milliseconds: 200));
                              ticketStore.setCurrentStatusIndex(1);
                              mainLog(message: "setCurrentStatusIndex");
                            },
                            child: Container(
                              width: context.width() / 2 - 20,
                              padding: EdgeInsets.all(10),
                              decoration: decoration,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Monthly Tickets", style: boldTextStyle()).fit(),
                                  8.height,
                                  Text(data.overview!.weeklyTickets.validate().toString(), style: boldTextStyle(color: context.primaryColor, size: 20)),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () async {
                              dashboardStore.setBottomNavigationCurrentIndex(1);
                              mainLog(message: "setBottomNavigationCurrentIndex");
                              await Future.delayed(Duration(milliseconds: 200));
                              ticketStore.setCurrentStatusIndex(0);
                              mainLog(message: "setCurrentStatusIndex");
                            },
                            child: Container(
                              width: context.width() / 2 - 20,
                              padding: EdgeInsets.all(10),
                              decoration: decoration,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Pending Approvals", style: boldTextStyle()).fit(),
                                  8.height,
                                  Text(data.overview!.pendingApprovals.validate().toString(), style: boldTextStyle(color: context.primaryColor, size: 20)),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () async {
                              dashboardStore.setBottomNavigationCurrentIndex(1);
                              mainLog(message: "setBottomNavigationCurrentIndex");
                              await Future.delayed(Duration(milliseconds: 200));
                              ticketStore.setCurrentStatusIndex(2);
                              mainLog(message: "setCurrentStatusIndex");
                            },
                            child: Container(
                              width: context.width() / 2 - 20,
                              padding: EdgeInsets.all(10),
                              decoration: decoration,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Resolved Tickets", style: boldTextStyle()).fit(),
                                  8.height,
                                  Text(data.overview!.resolvedTickets.validate().toString(), style: boldTextStyle(color: context.primaryColor, size: 20)),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: context.width() / 2 - 20,
                            padding: EdgeInsets.all(10),
                            decoration: decoration,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Monthly Payout", style: boldTextStyle()).fit(),
                                8.height,
                                Observer(builder: (context) {
                                  return Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AmountDisplayWidget(amount: "${userStore.currencyCode}${data.overview!.payout.validate().toStringAsFixed(2)}", show: !biometricAuthStore.isLocked),
                                      16.width,
                                      GestureDetector(
                                        onTap: () async {
                                          if (biometricAuthStore.isLocked) {
                                            await biometricAuthStore.authenticate();
                                          } else {
                                            biometricAuthStore.isLocked = true;
                                          }
                                        },
                                        child: !biometricAuthStore.isLocked.validate()
                                            ? AppSvgIcons.icPasswordShow.agLoadImage(width: 24, height: 24)
                                            : AppSvgIcons.icPasswordHide.agLoadImage(width: 24, height: 24),
                                      ),
                                    ],
                                  );
                                }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    16.height,
                    /*  Observer(
                      builder: (context) {
                        if (!userStore.isPhoneNumberVerified.validate())
                          return MobileVerificationDialogWidget();
                        else
                          return Offstage();
                      },
                    ),
                    16.height,*/
                    CompleteProfileWidget(),
                    ScreenTitleWidget("Today's Tickets"),
                    ScreenSubTitleWidget("Stay updated with the latest tasks and priorities for the day.", size: 12),
                    12.height,
                    AnimatedListView(
                      itemCount: data.tickets.validate().length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      emptyWidget: NoDataWidget(
                        imageSize: Size(40, 40),
                        title: "No Tickets for Today",
                        subTitle: "Enjoy the calm day, or check back later for new tasks.",
                      ).paddingTop(40),
                      itemBuilder: (context, index) {
                        TicketData ticketData = data.tickets.validate()[index];
                        return DashboardTicketWidget(data: ticketData).paddingTop(4);
                      },
                    ),
                  ],
                ),
              );
            }
            return snapWidgetHelper(snap, loadingWidget: aimLoader(context));
          }
          return snapWidgetHelper(snap, loadingWidget: aimLoader(context));
        },
      ),
    );
  }
}
