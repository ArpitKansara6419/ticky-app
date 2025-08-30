import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/tickets/ticket_data.dart';
import 'package:ticky/model/tickets/ticket_work_response.dart';
import 'package:ticky/utils/colors.dart';
import 'package:ticky/utils/enums.dart';
import 'package:ticky/utils/widgets/app_loader.dart';
import 'package:ticky/utils/widgets/common_app_bar.dart';
import 'package:ticky/utils/widgets/status_widget.dart';
import 'package:ticky/view/tickets/widgets/build_extra_info_section_component.dart';
import 'package:ticky/view/tickets/widgets/build_map_widget.dart';
import 'package:ticky/view/tickets/widgets/build_ticket_heading_widget.dart';
import 'package:ticky/view/tickets/widgets/build_ticket_scope_of_work.dart';
import 'package:ticky/view/tickets/work_status_screen.dart';

import 'background_location_service.dart';

class TicketsDetailScreen extends StatefulWidget {
  final TicketData ticketData;

  const TicketsDetailScreen({Key? key, required this.ticketData}) : super(key: key);

  @override
  State<TicketsDetailScreen> createState() => _TicketsDetailScreenState();
}

class _TicketsDetailScreenState extends State<TicketsDetailScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  Position? position;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    // Initial fetch of ticket data
    PermissionStatus permissionStatus = await Location().requestPermission();
    if (permissionStatus == PermissionStatus.granted) {
      position = await Geolocator.getCurrentPosition();
      mainLog(message: 'position => ${position != null}');
    }
    ticketStartWorkStore.handleTicketFuture(ticketId: widget.ticketData.id.validate());
  }

  Widget alertBoxComponent({required String title, required void Function() onTap}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              maxLines: 3,
              style: secondaryTextStyle(color: Colors.black, weight: FontWeight.w700),
            ),
          ),
          15.width,
          Icon(Icons.arrow_forward, size: 20, color: Colors.black),
        ],
      ),
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    // No explicit stop needed here. The background service manages its lifecycle
    // based on ticket status. It will stop if the ticket is closed/held.
    ticketStartWorkStore.attachmentFiles.clear();
    ticketStartWorkStore.ticketFuture = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return FutureBuilder<TicketWorkResponse>(
          future: ticketStartWorkStore.ticketFuture,
          builder: (context, snap) {
            if (snap.hasData) {
              final TicketData currentTicket = snap.data!.ticketData!;

              // This is the core logic for controlling the background service.
              // It checks the current ticket status and the service's current state.
              if (currentTicket.isProgress()) {
                // If the ticket is in progress and the service is not already tracking this ticket, start it.
                if (!backgroundLocationService.isTrackingTicket(currentTicket.id.validate())) {
                  backgroundLocationService.startTracking(currentTicket);
                }
              } else if (currentTicket.isClose() || currentTicket.isHold()) {
                // If the ticket is closed or on hold, stop the service if it was tracking this ticket.
                if (backgroundLocationService.isTrackingTicket(currentTicket.id.validate())) {
                  backgroundLocationService.stopTracking();
                }
              }
            }

            return Scaffold(
              appBar: commonAppBarWidget(
                widget.ticketData.ticketCode.validate(),
                actions: snap.hasData
                    ? [
                        StatusWidget(
                          status: snap.data!.ticketData!.engineerStatus.validate().isNotEmpty ? snap.data!.ticketData!.engineerStatus.validate() : snap.data!.ticketData!.ticketStatus.validate(),
                        ),
                        16.width,
                      ]
                    : null,
              ),
              body: RefreshIndicator(
                key: _refreshIndicatorKey,
                child: snap.hasData
                    ? Stack(
                        fit: StackFit.expand,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 24),
                            child: AnimatedScrollView(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              padding: EdgeInsets.only(bottom: 150, left: 12, top: 16, right: 12),
                              children: [
                                BuildTicketHeadingWidget(data: snap.data!.ticketData!),
                                BuildTicketScopeOfWork(data: snap.data!.ticketData!),
                                BuildMapWidget(
                                  ticketID: snap.data!.ticketData!.id ?? 0,
                                  address: snap.data!.ticketData!.toAddressJson(),
                                  addressLat: snap.data!.ticketData!.ticketLat.toDouble(),
                                  addressLng: snap.data!.ticketData!.ticketLng.toDouble(),
                                  inProgress: snap.data!.ticketData!.canStartWorkNew(),
                                  checkIsInRange: (isInRange) {
                                    mainLog(message: 'isInRange => $isInRange');
                                  },
                                ),
                                if (snap.data!.ticketData!.ticketStatus == "accepted") ...[
                                  BuildExtraInfoSection(data: snap.data!.ticketData!),
                                  WorkStatusScreen(
                                    workStatus: snap.data!.ticketData!.ticketWorks.validate(),
                                    ticketId: snap.data!.ticketData!.id.validate(),
                                    ticketData: snap.data!.ticketData!,
                                    onVerifyLocation: () async {
                                      // If the user manually clicks "Verify Location", ensure tracking starts.
                                      // This might trigger a restart if already active, but that's fine for user action.
                                      if (!backgroundLocationService.isTrackingTicket(snap.data!.ticketData!.id.validate())) {
                                        backgroundLocationService.startTracking(snap.data!.ticketData!);
                                      }
                                    },
                                    onTaskHoldOrEnd: () async {
                                      // When task is held or ended, explicitly stop tracking.
                                      // This is crucial as the UI action directly impacts tracking.
                                      backgroundLocationService.stopTracking();
                                    },
                                  ),
                                ]
                              ],
                            ),
                          ),
                        ],
                      )
                    : snapWidgetHelper(snap, loadingWidget: aimLoader(context)),
                onRefresh: () async {
                  ticketStartWorkStore.handleTicketFuture(
                    ticketId: widget.ticketData.id.validate(),
                  );
                  setState(() {});
                },
                notificationPredicate: (notification) {
                  return notification.depth == 0;
                },
                color: primaryColor,
              ),
            );
          },
        );
      },
    );
  }
}
