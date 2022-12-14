import 'package:sports_betting/Commons/BTStrings.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class BTDrawerHeaderComponent extends StatelessWidget {
  const BTDrawerHeaderComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue, Color(0xff006400)],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            btLogoImageAsset,
            height: 70,
          ),
          24.height,
          Text(
            'BETTING TIPS VIP BET',
            style: boldTextStyle(color: Colors.white),
          )
        ],
      ).paddingOnly(top: 8, left: 8, bottom: 4),
    ).withWidth(MediaQuery.of(context).size.width);
  }
}
