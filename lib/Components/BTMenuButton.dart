import 'package:sports_betting/Commons/BTColors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class BTMenuButton extends StatelessWidget {
  const BTMenuButton(
      {Key? key, this.onTap, required this.text, this.addWidth = 5})
      : super(key: key);
  final Function()? onTap;
  final String text;
  final double addWidth;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.grey,
      onTap: onTap,
      child: Container(
        height: 30,
        decoration: const BoxDecoration(
            color: btTopMenuButtonColor,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              text.toUpperCase(),
              style: primaryTextStyle(color: btPrimaryTextColor, size: 14),
            ).center().paddingAll(8).paddingSymmetric(horizontal: addWidth)),
      ),
    );
  }
}
