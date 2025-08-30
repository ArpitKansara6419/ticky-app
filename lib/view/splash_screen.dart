import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ticky/initialization.dart';
import 'package:ticky/utils/images.dart';
import 'package:ticky/view/auth/sign_in_screen.dart';
import 'package:ticky/view/dashboard/dashboard_view.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  double _starSize = 50;
  double _opacity = 0.0;
  bool _showText = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    // Start animation sequence
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _starSize = 200; // Increase size
      });
    });

    Future.delayed(Duration(milliseconds: 1500), () {
      setState(() {
        _starSize = 100; // Shrink back
        _opacity = 0.6; //
      });
    });

    Future.delayed(Duration(milliseconds: 2000), () {
      setState(() {
        _opacity = 1.0; // Show text
      });
    });

    Future.delayed(Duration(milliseconds: 3000), () async {
      _showText = true;
      setState(() {});

      if (userStore.isLoggedIn) {
        DashboardView().launch(context, pageRouteAnimation: PageRouteAnimation.Scale, isNewTask: true);
      } else {
        SignInScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Scale, isNewTask: true);
      }
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 1000),
              curve: Curves.easeInOut,
              width: _starSize,
              height: _starSize,
              child: Image.asset(AppImages.appLogo), // Use correct asset
            ),
            6.height,
            AnimatedOpacity(
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
              opacity: _opacity,
              child: _showText ? Image.asset(AppImages.appLogoName, height: 80, width: 200) : Container(height: 80, width: 200),
            ),
          ],
        ),
      ),
    );
  }
}
