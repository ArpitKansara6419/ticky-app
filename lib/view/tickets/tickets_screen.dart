import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/tickets/ticket_const.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/view/component/header_component.dart';
import 'package:ticky/view/tickets/widgets/tab_widget_screen.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({Key? key}) : super(key: key);

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    ticketListGlobalKey.currentState?.dispose();
    super.dispose();
  }

  void init() async {
    dashboardStore.initializeTabController(
      vsync: this,
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  String getStringText() {
    if (dashboardStore.tabController.index == 0) {
      return "These are tickets offered to you. Review the details and accept or reject them based on availability.";
    } else if (dashboardStore.tabController.index == 1) {
      return "Here are the tickets you've accepted. Make sure to complete them on time.";
    } else if (dashboardStore.tabController.index == 2) {
      return "Tickets successfully resolved and closed. Great job!";
    } else {
      return "These are tickets you have rejected. If needed, contact the admin for further clarification.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) => Scaffold(
      key: ticketListGlobalKey,
      appBar: HeaderComponent(name: MenuName.tickets),
      body: DefaultTabController(
        length: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            8.height,
            Container(
              height: kToolbarHeight - 8.0,
              margin: EdgeInsets.only(left: 8, right: 8),
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: radius(),
                boxShadow: defaultBoxShadow(spreadRadius: 0, blurRadius: 6),
              ),
              child: TabBar(
                controller: dashboardStore.tabController,

                labelStyle: primaryTextStyle(color: context.scaffoldBackgroundColor, size: 14),
                indicatorColor: context.primaryColor,
                unselectedLabelColor: Colors.black,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(borderRadius: radius(), color: context.primaryColor),
                tabAlignment: TabAlignment.center,
                dividerColor: Colors.transparent,
                padding: EdgeInsets.all(8),
                unselectedLabelStyle: secondaryTextStyle(color: Colors.white70, size: 14),
                tabs: [
                  Tab(text: EngineerTicketConst.offered.toUpperCase()),
                  Tab(text: EngineerTicketConst.accepted.toUpperCase()),
                  Tab(text: EngineerTicketConst.closed.toUpperCase()),
                  Tab(text: EngineerTicketConst.rejected.toUpperCase()),
                ],
                indicatorAnimation: TabIndicatorAnimation.elastic,
              ),
            ),
            16.height,
            TabBarView(
              controller: dashboardStore.tabController,
              children: [
                TabWidgetScreen(engineerStatus: EngineerTicketConst.offered),
                TabWidgetScreen(engineerStatus: EngineerTicketConst.accepted),
                TabWidgetScreen(status: EngineerTicketConst.closed),
                TabWidgetScreen(engineerStatus: EngineerTicketConst.rejected),
              ],
            ).expand()
          ],
        ),
      ),
    ),);
  }
}
