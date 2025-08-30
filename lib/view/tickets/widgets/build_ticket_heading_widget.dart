import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/model/tickets/ticket_data.dart';
import 'package:ticky/utils/imports.dart';
import 'package:ticky/utils/widgets/icon_text_widget.dart';
import 'package:ticky/view/tickets/widgets/section_widget.dart';

class BuildTicketHeadingWidget extends StatelessWidget {
  final TicketData data;

  const BuildTicketHeadingWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Task Details", style: boldTextStyle(color: context.primaryColor, size: 16)),
        4.height,
        SectionWidget(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.lead!.name.validate(), maxLines: 4, style: boldTextStyle()),
              10.height,
              IconTextWidget(
                icon: Icons.date_range_outlined,
                text: formatDate(data.taskStartDate.validate(), outputFormat: ShowDateFormat.ddMmmYyyyEeee),
                iconSize: 20,
              ),
              8.height,
              IconTextWidget(
                icon: Icons.access_time,
                text: formatTickyTime(data.taskTime.validate()),
                iconSize: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
