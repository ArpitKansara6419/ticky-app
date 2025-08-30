import 'package:flutter/material.dart';
import 'package:ticky/utils/date_utils.dart';

class GreetingWithIconModel {
  final String message;
  final IconData icon;
  final Color color;

  GreetingWithIconModel({required this.message, required this.icon, required this.color});
}

GreetingWithIconModel getGreetingWithIconModel() {
  final hour = DateTimeUtils.convertDateTimeToUTC(
    dateTime: DateTime.now(),
  ).hour;

  if (hour < 12) {
    return GreetingWithIconModel(
      message: 'Good Morning',
      icon: Icons.wb_sunny,
      color: Colors.orange, // Bright color for morning
    );
  } else if (hour < 17) {
    return GreetingWithIconModel(
      message: 'Good Afternoon',
      icon: Icons.wb_cloudy,
      color: Colors.blue, // Blue color for afternoon
    );
  } else {
    return GreetingWithIconModel(
      message: 'Good Evening',
      icon: Icons.nightlight_round,
      color: Colors.purple, // Purple color for evening
    );
  }
}
