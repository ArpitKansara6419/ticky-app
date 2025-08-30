import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/model/tickets/break_data.dart';
import 'package:ticky/model/tickets/ticket_data.dart';
import 'package:ticky/utils/config.dart';
import 'package:ticky/utils/geo_services/geo_functions.dart';

class BuildBreakListWidget extends StatelessWidget {
  final List<BreakData> breakList;
  final TicketData ticketData;
  final void Function() onVerifyLocation;

  const BuildBreakListWidget({
    Key? key,
    required this.breakList,
    required this.ticketData,
    required this.onVerifyLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool loader = false;
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
      child: Column(
        children: [
          Row(
            children: [
              Text('Breaks', style: secondaryTextStyle(color: context.primaryColor)).expand(),
              Text('Start Time', style: secondaryTextStyle(color: context.primaryColor), textAlign: TextAlign.end).expand(flex: 2),
              Text('End Time', style: secondaryTextStyle(color: context.primaryColor), textAlign: TextAlign.end).expand(flex: 2),
              Text('Total Time', style: secondaryTextStyle(color: context.primaryColor), textAlign: TextAlign.end).expand(flex: 2),
            ],
          ),
          2.height,
          AnimatedListView(
            itemCount: breakList.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            reverse: true,
            itemBuilder: (context, index) {
              BreakData data = breakList[index];
              return Row(
                children: [
                  Text(' ${index + 1}', style: secondaryTextStyle()).expand(),
                  Text(data.startTime.validate(), style: secondaryTextStyle(), textAlign: TextAlign.end).expand(flex: 2),
                  if (data.endTime != null)
                    Text(data.endTime.validate(value: "--"), style: secondaryTextStyle(), textAlign: TextAlign.end).expand(flex: 2)
                  else
                    StatefulBuilder(builder: (context, setState) {
                      return GestureDetector(
                        onTap: () async {
                          if (!loader) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                alignment: Alignment.center,
                                backgroundColor: Colors.white,
                                title: Text(
                                  'Verifying Location...',
                                  style: secondaryTextStyle(size: 15, color: Colors.black, weight: FontWeight.w700),
                                ),
                              ),
                            );
                            loader = true;
                            final Map<String, dynamic> result = await getDistanceFromLatLong(address: LatLng(ticketData.ticketLat.toDouble(), ticketData.ticketLng.toDouble()));
                            bool isWithinRange = (result["distance_meter"] as double).toInt() <= Config.allowedWorkRange;

                            loader = false;
                            Navigator.pop(context);
                            setState(() {});
                            if (isWithinRange) {
                              _handleEndBreakClick(context, data.id.validate(), TicketWorks());
                            } else {
                              toast('Out of Range');
                            }
                          }
                        },
                        child: Text('End Break', style: boldTextStyle(color: Colors.red, size: 12), textAlign: TextAlign.end),
                      );
                    }).expand(flex: 2),
                  Text(data.totalBreakTime.validate(value: "--"), style: secondaryTextStyle(), textAlign: TextAlign.end).expand(flex: 2),
                ],
              ).paddingSymmetric(vertical: 2);
            },
          ),
          Divider(),
          Row(
            children: [
              Text('Total Break Time', style: secondaryTextStyle(size: 12)).expand(),
              Text('${BreakData.calculateTotalBreakTime(breakList)}', style: boldTextStyle(size: 14)),
            ],
          ),
        ],
      ),
    );
  }

  void _handleEndBreakClick(BuildContext context, int ticketBreakId, TicketWorks data) async {
    await showConfirmDialogCustom(
      context,
      primaryColor: context.primaryColor,
      onAccept: (context) async {
        await ticketStartWorkStore.endTicketBreak(ticketBreakId: ticketBreakId, data: data);
        ticketStartWorkStore.refreshTicketDetails(ticketId: ticketData.id ?? -1000);
        await Future.delayed(Duration(seconds: 1));
        onVerifyLocation();
      },
    );
  }
}
