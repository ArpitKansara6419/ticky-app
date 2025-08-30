import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class FormComponentDeviceBased extends StatelessWidget {
  final Widget child1;
  final Widget child2;
  final int? widthBetweenWidget;
  final int child1Flex;
  final int child2Flex;

  const FormComponentDeviceBased({
    Key? key,
    required this.child1,
    required this.child2,
    this.widthBetweenWidget,
    this.child1Flex = 1,
    this.child2Flex = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildTabletWidget();
  }

  Widget buildTabletWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        child1.expand(flex: child1Flex),
        (widthBetweenWidget ?? 20).width,
        child2.expand(flex: child2Flex),
      ],
    );
  }
}
