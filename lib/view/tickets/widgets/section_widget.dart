import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class SectionWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const SectionWidget({Key? key, required this.child, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Blur(
      blur: 1,
      width: context.width(),
      borderRadius: radius(8),
      padding: padding ?? EdgeInsets.all(10),
      color: Colors.white,
      child: child,
    );
  }
}
