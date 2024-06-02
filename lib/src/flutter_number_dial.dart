import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:flutter_number_dial/src/rotation_dial_background.dart';
import 'package:flutter_number_dial/src/rotation_dial_config.dart';
import 'package:flutter_number_dial/src/rotation_dial_forground.dart';
import 'package:flutter_number_dial/src/simple_num_shape.dart';
import 'package:flutter_number_dial/src/utils.dart';

import 'dial_config_provider.dart';

class RotationDialInput extends StatefulWidget {
  const RotationDialInput({
    super.key,
    required this.onNumSelected,
    required this.animationDuration,
    required this.passcodeAnimationInProgress,
    this.inputNumbers = const [1, 2, 3, 4, 5, 6, 7, 8, 9, 0],
    this.ringPadding = 4.0,
    this.ringWidth = 70.0,
    this.singleNumberPadding = 8.0,
    this.firstNumPosition = pi / 3,
    this.maxRingAngle = pi * 7 / 4,
    this.maxSweepAngle = pi / 2 * 3,
    required this.textStyle,
    this.backgroundColor = Colors.black,
    this.foregroundColor = Colors.white,
    this.numberBackgroundColor = Colors.black,
    this.boxSize = 400.0,
    this.singleNumberRadius = 20,
  });

  final Duration animationDuration;
  final bool passcodeAnimationInProgress;
  final ValueSetter<int> onNumSelected;
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
  final double boxSize;
  final double singleNumberRadius;

  @override
  State<RotationDialInput> createState() => _RotationdialInputState();
}

class _RotationdialInputState extends State<RotationDialInput>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final AnimationController modeChangeController;

  var _crrentDragOffset = Offset.zero;
  var _startAngleOffset = 0.0;

  late Animation<double> rotationAnimation;
  late Animation<double> backgroundfade;
  late Animation<double> foregroundfade;

  bool get _isAnimating =>
      animationController.isAnimating ||
      modeChangeController.isAnimating ||
      widget.passcodeAnimationInProgress;

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: widget.animationDuration)
          ..addListener(() {
            setState(() {
              _startAngleOffset = rotationAnimation.value;
            });
          });

    modeChangeController = AnimationController(
      duration: widget.animationDuration * 2,
      vsync: this,
    )..addListener(() => setState(() {}));

    foregroundfade = Tween<double>(
      begin: widget.maxSweepAngle,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: modeChangeController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
      ),
    );

    backgroundfade = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: modeChangeController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  TickerFuture rotateDialToStart() {
    rotationAnimation = Tween<double>(
      begin: _startAngleOffset,
      end: 0,
    ).animate(CurvedAnimation(
        parent: animationController, curve: Curves.easeInOutCirc));

    animationController.reset();

    return animationController.forward();
  }

  void _onPanStart(DragStartDetails details, Offset centerOffset) {
    if (_isAnimating) return;

    _crrentDragOffset = details.localPosition - centerOffset;
  }

  void _onPanUpdate(DragUpdateDetails details, Offset centerOffset) {
    if (_isAnimating) return;

    final previousOffset = _crrentDragOffset;
    _crrentDragOffset += details.delta;

    final currentDirection = _crrentDragOffset.direction;
    final previousDirection = previousOffset.direction;

    if (currentDirection * previousDirection < 0.0) return;

    final angle = _startAngleOffset + currentDirection - previousDirection;

    if (angle < 0.0 || angle >= widget.maxRingAngle) return;

    setState(() => _startAngleOffset = angle);
  }

  void _onPanEnd(DragEndDetails details) {
    if (_isAnimating) return;

    final offset = widget.firstNumPosition * (_startAngleOffset - 1);

    if (offset < -pi / 12) {
      rotateDialToStart();

      return;
    }

    final numberIndex = ((offset * 180 / pi).abs() / 30).round();

    hm(widget.inputNumbers[numberIndex]);
  }

  void hm(int numberIndex) {
    widget.onNumSelected(numberIndex);
    rotateDialToStart();
  }

  @override
  Widget build(BuildContext context) {
    final config = DialConfig(
      inputNumbers: widget.inputNumbers,
      ringPadding: widget.ringPadding,
      ringWidth: widget.ringWidth,
      singleNumberPadding: widget.singleNumberPadding,
      firstNumPosition: widget.firstNumPosition,
      maxRingAngle: widget.maxRingAngle,
      maxSweepAngle: widget.maxSweepAngle,
      textStyle: widget.textStyle,
      backgroundColor: widget.backgroundColor,
      foregroundColor: widget.foregroundColor,
      numberBackgroundColor: widget.numberBackgroundColor,
      singleNumberRadius: widget.singleNumberRadius,
    );

    var inputvar = widget.inputNumbers;
    return DialConfigProvider(
      config: config,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = widget.boxSize;
          final size = Size(width, width);

          final numDistFromCenter = width / 2 -
              16 -
              widget.ringPadding * 2 -
              widget.singleNumberPadding * 2;

          return Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: size,
                painter: RotationDialBackground(
                  config,
                  opacity: backgroundfade.value,
                ),
              ),
              for (var i = 0; i < inputvar.length; i++)
                Transform.translate(
                  offset: Offset.fromDirection(
                    (i + 1) * -pi / 6,
                    numDistFromCenter,
                  ),
                  child: Numbershape(inputvar[i]),
                ),
              GestureDetector(
                onPanStart: (details) =>
                    _onPanStart(details, size.centeroffset),
                onPanUpdate: (details) =>
                    _onPanUpdate(details, size.centeroffset),
                onPanEnd: _onPanEnd,
                child: CustomPaint(
                  size: size,
                  painter: RotationDialForeground(
                    config,
                    numRadiusFromCenter: numDistFromCenter,
                    startAngleOffset: _startAngleOffset,
                    sweepAngle: foregroundfade.value,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
