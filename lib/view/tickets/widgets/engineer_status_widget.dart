import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/utils/colors.dart';

class EngineerStatusWidget extends StatelessWidget {
  final String status;

  EngineerStatusWidget({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'inprogress':
        bgColor = Color(0xFF9CD326); // Sunflower Yellow background
        textColor = Color(0xFFFFFFFF); // Golden Yellow text
        break;

      case 'hold':
        bgColor = Color(0xFFe2445c); // Light Blue background
        textColor = Color(0xFFFFFFFF); // Darker Blue text
        break;

      case 'break':
        bgColor = Color(0xFFFF642E); // Lemon Yellow background
        textColor = Color(0xFFFFFFFF); // Bright Yellow text
        break;

      case 'close':
        bgColor = primaryColor; // Brown background
        textColor = Color(0xFFFFFFFF); // Dark Brown text
        break;

      case 'expire':
        bgColor = Colors.red;
        textColor = Color(0xFFFFFFFF);
        break;

      case 'expired':
        bgColor = Colors.red;
        textColor = Color(0xFFFFFFFF);
        break;

      default:
        bgColor = Color(0xFF000000);
        textColor = Color(0xFFFFFFFF);
    }

    return status.isEmpty
        ? Offstage()
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: bgColor, borderRadius: radius()),
            child: Text(status.capitalizeEachWord(), style: secondaryTextStyle(color: textColor, size: 12)),
          );
  }
}
