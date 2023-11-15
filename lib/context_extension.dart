import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  bool get isDarkMode {
    final themeMode = findAncestorWidgetOfExactType<MaterialApp>()?.themeMode ?? ThemeMode.system;
    return themeMode == ThemeMode.system ? MediaQuery.of(this).platformBrightness == Brightness.dark : themeMode == ThemeMode.dark;
  }
}
