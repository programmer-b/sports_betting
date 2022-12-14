import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class BTMovingTextComponent extends StatelessWidget {
  const BTMovingTextComponent(
      {Key? key, required this.textColor, this.decoration, required this.text})
      : super(key: key);

  final Color textColor;
  final BoxDecoration? decoration;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      height: 25,
      child: Marquee(
        pauseDuration: const Duration(seconds: 0),
        animationDuration: const Duration(milliseconds: 16000),
        directionMarguee: DirectionMarguee.oneDirection,
        child: Text(
          text,
          style: boldTextStyle(color: textColor),
        ).center(),
      ),
    ).withWidth(double.infinity);
  }
}
