import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

const String offered = "offered";
const String accepted = "accepted";
const String inprogress = "inprogress";
const String hold = "hold";
const String breaks = "break";
const String close = "close";
const String expire = "expire";
const String expired = "expired";

class StatusWidget extends StatelessWidget {
  final String status;
  final bool darkBackground;
  final bool frosted;

  const StatusWidget({
    Key? key,
    required this.status,
    this.darkBackground = true,
    this.frosted = false,
  }) : super(key: key);

  // Color mapping
  static const Map<String, Color> _darkBgColors = {
    'all': Color(0xFF607D8B),
    offered: Color(0xFF1976D2),
    accepted: Color(0xFF388E3C),
    inprogress: Color(0xFFFBC02D),
    hold: Color(0xFFFFA000),
    breaks: Color(0xFF7B1FA2), // Purple for break
    close: Color(0xFF616161),
    expire: Color(0xFFD32F2F),
    expired: Color(0xFFD32F2F),
  };

  static const Map<String, Color> _lightBgColors = {
    'all': Color(0xFFECEFF1),
    offered: Color(0xFFE3F2FD),
    accepted: Color(0xFFE8F5E9),
    inprogress: Color(0xFFFFFDE7),
    hold: Color(0xFFFFF3E0),
    breaks: Color(0xFFF3E5F5), // Light purple for break
    close: Color(0xFFF5F5F5),
    expire: Color(0xFFFFEBEE),
    expired: Color(0xFFFFEBEE),
  };

  static const Map<String, Color> _darkTextColors = {
    'all': Color(0xFF263238),
    offered: Color(0xFF0D47A1),
    accepted: Color(0xFF1B5E20),
    inprogress: Color(0xFFF57C00),
    hold: Color(0xFFE65100),
    breaks: Color(0xFF4A148C), // Dark purple for break
    close: Color(0xFF212121),
    expire: Color(0xFFB71C1C),
    expired: Color(0xFFB71C1C),
  };

  // Normalize status string for matching
  String _normalizeStatus(String s) {
    return s.toLowerCase().replaceAll(' ', '').replaceAll('_', '');
  }

  @override
  Widget build(BuildContext context) {
    if (status.isEmpty) return Offstage();
    final String normalized = _normalizeStatus(status);
    // Map normalized status to color map keys
    String key = _darkBgColors.keys.firstWhere(
      (k) => _normalizeStatus(k) == normalized,
      orElse: () => 'all',
    );

    final bgColor = darkBackground ? _darkBgColors[key]! : _lightBgColors[key]!;
    final textColor = darkBackground ? Colors.white : _darkTextColors[key]!;

    Widget child = Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor.withOpacity(frosted ? 0.5 : 1.0),
        borderRadius: radius(),
      ),
      child: Text(
        status[0].toUpperCase() + status.substring(1),
        style: secondaryTextStyle(color: textColor, letterSpacing: 1.1, size: 12),
      ),
    );

    if (frosted) {
      child = ClipRRect(
        borderRadius: radius(),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: child,
        ),
      );
    }

    return child;
  }
}
