import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/model/tickets/ticket_data.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/utils/widgets/status_widget.dart';
import 'package:ticky/view/tickets/tickets_detail_screen.dart';

class TaskWidget extends StatelessWidget {
  final TicketData? data;
  final bool? isOptionEnabled;
  final void Function()? refreshScreen;
  final List<int>? inProgressTicketIds;

  const TaskWidget({
    Key? key,
    this.data,
    this.isOptionEnabled,
    this.refreshScreen,
    this.inProgressTicketIds,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data == null) return Offstage();
    // return GestureDetector(
    //   onTap: () {
    //     TicketsDetailScreen(ticketId: data!.id.validate(), ticketCode: data!.ticketCode.validate()).launch(context);
    //   },
    //   child: Container(
    //     margin: EdgeInsets.only(top: 4, bottom: 4),
    //     padding: EdgeInsets.all(12),
    //     decoration: BoxDecoration(color: Colors.white, borderRadius: radius(), boxShadow: defaultBoxShadow(blurRadius: 4, spreadRadius: 0)),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         Row(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: [
    //             Text("#${data!.ticketCode}", style: boldTextStyle(size: 14)).expand(),
    //             if (data!.engineerStatus.validate().isEmpty) TicketStatusWidget(status: data!.ticketStatus.validate()),
    //             EngineerStatusWidget(status: data!.engineerStatus.validate()),
    //           ],
    //         ),
    //         Text('${data!.lead?.name.validate()}', style: boldTextStyle(color: context.primaryColor)),
    //         6.height,
    //         if (DateTime.parse(data!.taskStartDate.validate()).difference(DateTime.parse(data!.taskEndDate.validate())).inDays == 0)
    //           Text("📅 ${formatDate(data!.taskStartDate.validate())}", style: secondaryTextStyle())
    //         else
    //           Text("📅 ${formatDate(data!.taskStartDate.validate())}" + " → " + " ${formatDate(data!.taskEndDate.validate())}", style: secondaryTextStyle()),
    //         4.height,
    //         Text('⏰ ${formatTickyTime(data!.taskTime.validate())}', style: secondaryTextStyle()),
    //         4.height,
    //         Text('📍 ${data!.toAddressJson().capitalizeEachWord()}', style: secondaryTextStyle(size: 13)),
    //         /*  if (data!.canStartWork(focusedDay: focusedDate) && (data!.engineerStatus == null || data!.isHold())) ...{
    //           Text((data!.canStartWork(focusedDay: focusedDate) && (data!.engineerStatus == null || data!.isHold())).toString()),
    //         } else ...{
    //           Text((data!.canStartWork(focusedDay: focusedDate) && (data!.engineerStatus == null || data!.isProgress())).toString()),
    //         }*/
    //       ],
    //     ),
    //   ),
    // );
    return Container(
      margin: isOptionEnabled.validate() ? null : EdgeInsets.only(top: 4, bottom: 4),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: isOptionEnabled.validate() ? radiusOnly(topLeft: defaultRadius, topRight: defaultRadius) : radius(),
      ),
      child: InkWell(
        onTap: () {
          TicketsDetailScreen(ticketData: data!).launch(context, pageRouteAnimation: Platform.isIOS ? null : PageRouteAnimation.Slide).then(
            (value) {
              if (refreshScreen != null) {
                refreshScreen!();
              }
            },
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("#${data!.ticketCode}", style: boldTextStyle(size: 14)).expand(),
                StatusWidget(status: data!.engineerStatus.validate().isNotEmpty ? data!.engineerStatus.validate() : data!.ticketStatus.validate()),
              ],
            ),
            if (data!.lead != null) ...[
              10.height,
              Text('${data!.lead!.name.validate()}', style: boldTextStyle(color: context.primaryColor)),
            ],
            6.height,
            if (DateTime.parse(data!.taskStartDate.validate()).difference(DateTime.parse(data!.taskEndDate.validate())).inDays == 0)
              Text("📅 ${formatDate(data!.taskStartDate.validate())}", style: secondaryTextStyle())
            else
              Text("📅 ${formatDate(data!.taskStartDate.validate())}" + " → " + " ${formatDate(data!.taskEndDate.validate())}", style: secondaryTextStyle()),
            4.height,
            Text('⏰ ${formatTickyTime(data!.taskTime.validate())}', style: secondaryTextStyle()),
            4.height,
            Text('📍 ${data!.toAddressJson().capitalizeEachWord()}', style: secondaryTextStyle(size: 13)),
          ],
        ),
      ),
    );
  }
}
