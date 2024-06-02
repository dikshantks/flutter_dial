import 'package:flutter/material.dart';
import 'package:flutter_number_dial/src/dial_config_provider.dart';

class Numbershape extends StatelessWidget {
  const Numbershape(
    this.num, {
    super.key,
  });

  final int num;

  @override
  Widget build(BuildContext context) {
    final config = DialConfigProvider.of(context);

    return Container(
      alignment: Alignment.center,
      height: config.singleNumberRadius * 2,
      width: config.singleNumberRadius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle, color: config.numberBackgroundColor,
        // border,
      ),
      child: Text(
        "$num",
        style: config.textStyle,
      ),
    );
  }
}
