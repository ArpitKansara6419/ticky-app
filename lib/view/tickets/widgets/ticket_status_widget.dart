import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class TicketStatusWidget extends StatelessWidget {
  final String status;

  TicketStatusWidget({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'offered':
        bgColor = Color(0xFFFDAB3D); // Blue background
        textColor = Color(0xFFFFFFFF); // White text
        break;

      case 'accepted':
        bgColor = Color(0xFFCAB641); // Green background
        textColor = Color(0xFFFFFFFF); // White text
        break;

      case 'rejected':
        bgColor = Color(0xFFF44336); // Red background
        textColor = Color(0xFFFFFFFF); // White text
        break;

      default:
        bgColor = Colors.grey[100]!;
        textColor = Colors.black;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: bgColor, borderRadius: radius()),
      child: Text(status.capitalizeEachWord(), style: secondaryTextStyle(color: textColor, size: 12)),
    );
  }
}
