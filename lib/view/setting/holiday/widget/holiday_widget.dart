import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/model/holiday/holiday_data.dart';
import 'package:ticky/utils/common.dart';
import 'package:ticky/utils/date_utils.dart';

class HolidayWidget extends StatelessWidget {
  final HolidayData data;

  const HolidayWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = DateTime.tryParse(data.date.validate())!.isAfter(DateTimeUtils.convertDateTimeToUTC(
      dateTime: DateTime.now(),
    )) ? greenColor : Colors.red;
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(color: Colors.white, borderRadius: radius()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.calendar_month_outlined),
              8.width,
              Text('${formatClockInDateTime(DateTime.tryParse(data.date.validate())!, format: "dd MMM yyyy")}', style: primaryTextStyle()),
              Spacer(),
              Text('${formatClockInDateTime(DateTime.tryParse(data.date.validate())!, format: "EEEE")}', style: secondaryTextStyle(fontStyle: FontStyle.italic)),
            ],
          ),
          8.height,
          Row(
            children: [
              Text(data.title.validate(), style: boldTextStyle()),
              Spacer(),
              Text(
                DateTime.tryParse(data.date.validate())!.isAfter(DateTimeUtils.convertDateTimeToUTC(
                  dateTime: DateTime.now(),
                )) ? "Active" : "Expired",
                style: secondaryTextStyle(color: color, size: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
