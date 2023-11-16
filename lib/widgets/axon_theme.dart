import 'dart:io';

import 'package:flutter/widgets.dart';

class AxonThemeData {
  final double borderRadius;
  final Duration normalDuration;
  final Duration pressedDuration;
  final double desktopIconSize;
  final double mobileIconSize;
  final double desktopFontSize;
  final double mobileFontSize;
  final Curve curve;

  bool get isMobile => Platform.isAndroid || Platform.isIOS;

  double get fontSize => isMobile ? mobileFontSize : desktopFontSize;
  double get iconSize => isMobile ? mobileIconSize : desktopIconSize;

  const AxonThemeData({
    this.borderRadius = 4,
    this.normalDuration = const Duration(milliseconds: 50),
    this.pressedDuration = const Duration(milliseconds: 0),
    this.desktopIconSize = 16,
    this.mobileIconSize = 18,
    this.desktopFontSize = 14,
    this.mobileFontSize = 16,
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
