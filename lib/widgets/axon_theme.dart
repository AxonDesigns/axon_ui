import 'package:flutter/widgets.dart';

class AxonThemeData {
  final double borderRadius;
  final Duration normalDuration;
  final Duration pressedDuration;
  final double iconSize;
  final double fontSize;
  final Curve curve;

  const AxonThemeData({
    this.borderRadius = 4,
    this.normalDuration = const Duration(milliseconds: 50),
    this.pressedDuration = const Duration(milliseconds: 0),
    this.iconSize = 16,
    this.fontSize = 14,
    this.curve = Curves.fastEaseInToSlowEaseOut,
  });
}

class AxonTheme extends InheritedWidget {
  const AxonTheme({
    super.key,
    required this.data,
    required super.child,
  });

  final AxonThemeData data;

  static AxonThemeData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AxonTheme>()?.data;
  }

  static AxonThemeData of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<AxonTheme>())?.data ?? const AxonThemeData();
  }

  @override
  bool updateShouldNotify(covariant AxonTheme oldWidget) {
    return oldWidget.data != data;
  }
}
