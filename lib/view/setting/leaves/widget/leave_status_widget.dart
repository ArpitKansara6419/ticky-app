import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class LeaveStatusWidget extends StatelessWidget {
  final String status;

  const LeaveStatusWidget({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    String displayText;

    switch (status.toLowerCase()) {
      case 'approved':
        backgroundColor = Color(0xFFd4edda);
        textColor = Color(0xFF28a745);
        displayText = 'Approved';
        break;
      case 'reject':
        backgroundColor = Color(0xFFf8d7da);
        textColor = Color(0xFFdc3545);
        displayText = 'Rejected';
        break;
      case 'pending':
      default:
        backgroundColor = Color(0xFFf7ebeb);
        textColor = Color(0xFFff7970);
        displayText = 'Pending';
        break;
    }
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
