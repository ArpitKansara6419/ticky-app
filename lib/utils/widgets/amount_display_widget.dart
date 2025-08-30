import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class AmountDisplayWidget extends StatelessWidget {
  final String amount; // The actual amount to display
  final bool show; // Determines whether to show the actual amount or hide it

  const AmountDisplayWidget({
    Key? key,
    required this.amount,
    required this.show,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      show ? amount : '*' * amount.length, // Dynamically generate * based on the length of the amount
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: show ? context.primaryColor : Colors.grey,
      ),
    );
  }
}
