import 'package:flutter/material.dart';

class AnimatedVisibility extends StatelessWidget {
  const AnimatedVisibility({
    super.key,
    required this.duration,
    this.curve = Curves.fastEaseInToSlowEaseOut,
    this.visible = true,
    required this.child,
  });

  final Duration duration;
  final Curve curve;
  final bool visible;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !visible,
      child: AnimatedOpacity(
        opacity: visible ? 1 : 0,
        duration: duration,
        curve: curve,
        child: child,
      ),
    );
  }
}
