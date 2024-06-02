import 'package:flutter/material.dart';
import 'package:flutter_number_dial/src/utils.dart';

import 'dart:math' show pi;

import 'rotation_dial_config.dart';

class RotationDialBackground extends CustomPainter {
  const RotationDialBackground(this.config, {required this.opacity});

  final double opacity;

  final DialConfig config;
  @override
  void paint(Canvas canvas, Size size) {
    var ringWidth = config.ringWidth;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = ringWidth
      ..color = config.backgroundColor.withOpacity(opacity);

    canvas.drawArc(
        Rect.fromCircle(
          center: size.centeroffset,
          radius: size.width / 2 - ringWidth / 2,
        ),
        0,
        pi * 2,
        false,
        paint);
  }

  @override
  bool shouldRepaint(RotationDialBackground oldDelegate) =>
      oldDelegate.opacity != opacity;
}
