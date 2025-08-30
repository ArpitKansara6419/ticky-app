import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/model/leaves/leave_data.dart';
import 'package:ticky/utils/colors.dart';

class PaidUnpaidWidget extends StatelessWidget {
  final LeaveData data;

  const PaidUnpaidWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    String displayText;
    backgroundColor = primaryColor;
    textColor = Colors.white;

    if (data.paidFromDate != null) {
      displayText = 'Paid Leave Request';
    } else if (data.unpaidFromDate != null) {
      displayText = 'Unpaid Leave Request';
    } else {
      displayText = 'Paid Leave Request';
    }
    return Text(
      displayText,
      style: primaryTextStyle(size: 14, color: context.primaryColor),
    );
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        displayText,
        style: secondaryTextStyle(color: textColor, size: 12),
      ),
    );
  }
}
