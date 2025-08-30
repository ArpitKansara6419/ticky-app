import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ShakeText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration duration;

  const ShakeText({
    Key? key,
    required this.text,
    this.style,
    this.duration = const Duration(milliseconds: 500),
  }) : super(key: key);

  @override
  _ShakeTextState createState() => _ShakeTextState();
}

class _ShakeTextState extends State<ShakeText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(begin: -5.0, end: 5.0).chain(CurveTween(curve: Curves.elasticIn)).animate(_controller);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });

    _startShake();
  }

  void _startShake() {
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_animation.value, 0),
          child: child,
        );
      },
      child: Text(
        widget.text,
        style: widget.style ?? primaryTextStyle(size: 14, color: context.theme.colorScheme.error),
      ),
    );
  }
}
