import 'package:sports_betting/Commons/BTStrings.dart';
import 'package:flutter/material.dart';

class BTBackgroundComponent extends StatelessWidget {
  const BTBackgroundComponent({Key? key, required this.child})
      : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(btBackgroundImageAsset), fit: BoxFit.cover),
          color: Colors.black),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xaa3a243b),
          Color(0xbb3a243b),
          Color(0xcc000000)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: child,
      ),
    );
  }
}
