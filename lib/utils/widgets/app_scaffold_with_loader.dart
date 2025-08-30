import 'package:ticky/utils/widgets/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class AppScaffoldWithLoader extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const AppScaffoldWithLoader({Key? key, required this.isLoading, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        IgnorePointer(
          ignoring: isLoading,
          child: child,
        ),
        AppLoader().visible(isLoading).center(),
      ],
    );
  }
}
