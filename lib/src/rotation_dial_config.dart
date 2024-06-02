import 'dart:math' show pi;
import 'package:flutter/material.dart';

class DialConfig {
  final List<int> inputNumbers;
  final double ringPadding;
  final double ringWidth;
  final double singleNumberPadding;
  final double firstNumPosition;
  final double maxRingAngle;
  final double maxSweepAngle;
  final TextStyle textStyle;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color numberBackgroundColor;
  final double singleNumberRadius;

  DialConfig({
    this.inputNumbers = const [1, 2, 3, 4, 5, 6, 7, 8, 9, 0],
    this.ringPadding = 4.0,
    this.ringWidth = 80.0,
    this.singleNumberPadding = 8.0,
    this.firstNumPosition = pi / 3,
    this.maxRingAngle = pi * 7 / 4,
    this.maxSweepAngle = pi / 2 * 3,
    this.singleNumberRadius = 30.0,
    required this.textStyle,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.numberBackgroundColor,
  });

  // double get singleNumberRadius =>
  //     ringWidth / 2 - (ringPadding + singleNumberPadding);
}
