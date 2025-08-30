import 'package:ticky/utils/widgets/loader/circle_spinkit/spin_kit_circle.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class AppLoader extends StatelessWidget {
  final double? size;
  final Color? color;

  const AppLoader({Key? key, this.size, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return aimLoader(context, color: color, size: size);
  }
}

Widget aimLoader(BuildContext context, {double? size, Color? color}) {
  return SpinKitCircle(size: size ?? 46, color: color ?? context.primaryColor);
}

Widget buttonLoader(BuildContext context, {double? size, Color? color}) {
  return CircularProgressIndicator(color: color ?? context.primaryColor, strokeWidth: 2).withSize(width: size ?? 46, height: size ?? 46);
}

class ButtonAppLoader extends StatelessWidget {
  final double? size;
  final Color? color;
  final bool isLoading;
  final Widget child;

  ButtonAppLoader({this.size, this.color, required this.isLoading, required this.child});

  @override
  Widget build(BuildContext context) {
    return isLoading ? aimLoader(context, size: size ?? 26, color: color).center() : child;
  }
}
