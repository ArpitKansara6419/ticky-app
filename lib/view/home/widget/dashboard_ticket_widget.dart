import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/model/tickets/ticket_data.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/utils/widgets/status_widget.dart';
import 'package:ticky/view/tickets/tickets_detail_screen.dart';

class DashboardTicketWidget extends StatelessWidget {
  final TicketData? data;
  final DateTime? focusedDate;

  const DashboardTicketWidget({Key? key, this.data, this.focusedDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        TicketsDetailScreen(ticketData: data!).launch(context);
      },
      child: Container(
        margin: EdgeInsets.only(top: 4, bottom: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: radius(), boxShadow: defaultBoxShadow(blurRadius: 4, spreadRadius: 0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("#${data!.ticketCode}", style: boldTextStyle(size: 14)).expand(),
                StatusWidget(status: data!.engineerStatus.validate().isNotEmpty ? data!.engineerStatus.validate() : data!.ticketStatus.validate()),
              ],
            ),
            4.height,
            Text('${data!.lead?.name.validate()}', style: boldTextStyle(color: context.primaryColor)),
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
