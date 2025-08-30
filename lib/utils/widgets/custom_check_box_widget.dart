import 'package:ticky/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class CustomCheckBoxWidget extends StatelessWidget {
  final bool isChecked;

  const CustomCheckBoxWidget({Key? key, required this.isChecked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 18,
      width: 18,
      decoration: BoxDecoration(
        borderRadius: radius(4),
        color: isChecked ? context.primaryColor : null,
        border: isChecked ? null : Border.all(color: borderColor),
      ),
      child: isChecked ? Icon(Icons.done, size: 15, color: isChecked ? Colors.white : null) : null,
    );
  }
}
