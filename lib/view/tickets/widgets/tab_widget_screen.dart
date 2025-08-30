import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/controller/store/app_loader_store.dart';
import 'package:ticky/controller/tickets/ticket_controller.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/tickets/ticket_const.dart';
import 'package:ticky/model/tickets/ticket_data.dart';
import 'package:ticky/model/tickets/ticket_response.dart';
import 'package:ticky/utils/colors.dart';
import 'package:ticky/utils/widgets/app_loader.dart';
import 'package:ticky/utils/widgets/no_data_custom_widget.dart';
import 'package:ticky/view/tickets/widgets/task_option_widget.dart';
import 'package:ticky/view/tickets/widgets/task_widget.dart';

class TabWidgetScreen extends StatefulWidget {
  final String? status;
  final String? engineerStatus;

  const TabWidgetScreen({Key? key, this.status, this.engineerStatus}) : super(key: key);

  @override
  State<TabWidgetScreen> createState() => _TabWidgetScreenState();
}

class _TabWidgetScreenState extends State<TabWidgetScreen> {
  Future<TicketListResponse>? future;
  List<int>? inProgressTicketId;
  final GlobalKey<RefreshIndicatorState> _refreshListIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    future = TicketController.getTicketListApi(status: widget.status, engineer_status: widget.engineerStatus);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TicketListResponse>(
      future: future,
      builder: (context, snap) {
        if (snap.hasData) {
          return RefreshIndicator(
            key: _refreshListIndicatorKey,
            onRefresh: () async => init(),
            notificationPredicate: (notification) {
              return notification.depth == 0;
            },
            color: primaryColor,
            child: AnimatedListView(
              listAnimationType: ListAnimationType.None,
              padding: EdgeInsets.all(10),
              itemCount: snap.data!.ticketData!.length,
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              emptyWidget: NoDataCustomWidget(title: "No tickets are available."),
              itemBuilder: (context, index) {
                TicketData data = snap.data!.ticketData![index];
                return Observer(
                  warnWhenNoObservables: false,
                  builder: (context) {
                    if (widget.engineerStatus == EngineerTicketConst.offered) {
                      return TaskOptionWidget(
                        acceptLoader: dashboardStore.tabController.index == index && appLoaderStore.appLoadingState[AppLoaderStateName.ticketAcceptedStatusApiState].validate(),
                        hideOptions: data.ticketStatus != "offered",
                        onReject: () async {
                          await showConfirmDialogCustom(
                            context,
                            dialogType: DialogType.DELETE,
                            title: "Are you sure you don't want to do this job?",
                            onAccept: (context) async {
                              ticketStore.setCurrentStatusIndex(index);

                              await ticketStore.updateTicketStatus(ticketId: data.id.validate(), status: EngineerTicketConst.rejected);

                              ticketStore.setCurrentStatusIndex(0);

                              init();
                            },
                          );
                        },
                        onAccept: () async {
                          await showConfirmDialogCustom(
                            context,
                            dialogType: DialogType.CONFIRMATION,
                            primaryColor: context.primaryColor,
                            onAccept: (context) async {
                              ticketStore.setCurrentStatusIndex(index);

                              await ticketStore.updateTicketStatus(ticketId: data.id.validate(), status: EngineerTicketConst.accepted);

                              ticketStore.setCurrentStatusIndex(0);

                              init();
                            },
                          );
                        },
                        // child: DashboardTicketWidget(data: data).paddingTop(4),
                        child: TaskWidget(
                          data: data,
                          isOptionEnabled: true,
                          refreshScreen: init,
                          inProgressTicketIds: inProgressTicketId,
                        ),
                      );
                    } else {
                      return TaskWidget(
                        data: data,
                        isOptionEnabled: true,
                        refreshScreen: init,
                        inProgressTicketIds: inProgressTicketId,
                      ).paddingTop(8);
                    }
                  },
                );
              },
            ),
          );
        }

        return snapWidgetHelper(snap, loadingWidget: aimLoader(context));
      },
    );
  }
}
