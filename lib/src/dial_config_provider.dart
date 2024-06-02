import 'package:flutter/material.dart';
import 'package:flutter_number_dial/src/rotation_dial_config.dart';

class DialConfigProvider extends InheritedWidget {
  final DialConfig config;

  const DialConfigProvider({
    super.key,
    required this.config,
    required super.child,
  });

  static DialConfig of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<DialConfigProvider>()!
        .config;
  }

  @override
  bool updateShouldNotify(DialConfigProvider oldWidget) {
    return config != oldWidget.config;
  }
}
