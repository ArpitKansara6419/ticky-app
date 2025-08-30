import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class MyActivityWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const MyActivityWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: radius(),
      ),
      width: context.width() / 3 - 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: context.primaryColor.withOpacity(0.2),
              borderRadius: radius(),
            ),
            child: Icon(icon, size: 22, color: context.primaryColor),
          ),
          8.height,
          Text(title, style: primaryTextStyle()).fit(),
          4.height,
          Text(value.validate(value: "- -"), style: boldTextStyle(size: 16)),
        ],
      ),
    );
  }
}
