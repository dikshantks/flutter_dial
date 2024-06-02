import 'package:flutter/material.dart';
import 'dart:math' show pi;

import 'package:flutter_number_dial/src/rotation_dial_config.dart';
import 'package:flutter_number_dial/src/utils.dart';

class RotationDialForeground extends CustomPainter {
  const RotationDialForeground(
    this.config, {
    required this.numRadiusFromCenter,
    required this.startAngleOffset,
    required this.sweepAngle,
  });

  final double numRadiusFromCenter;
  final double startAngleOffset;
  final double sweepAngle;

  final DialConfig config;

  @override
  void paint(Canvas canvas, Size size) {
    var firstNumPosition = config.firstNumPosition;
    var ringWidth = config.ringWidth;

    final angleOffset = startAngleOffset * firstNumPosition;

    final paint = Paint()
      ..color = config.foregroundColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = ringWidth - config.ringPadding * 2
      ..style = PaintingStyle.stroke;

    canvas
      ..saveLayer(Rect.largest, paint)
      ..drawArc(
        Rect.fromCircle(
          center: size.centeroffset,
          radius: size.width / 2 - ringWidth / 2,
        ),
        angleOffset + firstNumPosition,
        sweepAngle,
        false,
        paint,
      );

    for (int i = 0; i < 10; i++) {
      final offset = Offset.fromDirection(
        angleOffset + pi * (-30 - i * 30) / 180,
        numRadiusFromCenter,
      );

      canvas.drawCircle(
        size.centeroffset + offset,
        config.singleNumberRadius,
        Paint()..blendMode = BlendMode.clear,
      );
    }

    canvas.drawCircle(
      size.centeroffset + Offset.fromDirection(pi / 6, numRadiusFromCenter),
      ringWidth / 6,
      Paint()
        ..color = config.foregroundColor.withOpacity(
          sweepAngle / config.maxSweepAngle,
        ),
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(RotationDialForeground oldDelegate) =>
      oldDelegate.numRadiusFromCenter != numRadiusFromCenter &&
      oldDelegate.startAngleOffset != startAngleOffset &&
      oldDelegate.sweepAngle != sweepAngle;
}
