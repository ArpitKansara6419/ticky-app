import 'package:flutter/material.dart';
import 'package:ticky/utils/widgets/common_app_bar.dart';

class StatementScreen extends StatelessWidget {
  const StatementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBarWidget("Statements"),
    );
  }
}
