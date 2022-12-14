import 'package:sports_betting/Screens/BTAboutUsScreen.dart';
import 'package:sports_betting/Screens/BTContactUsScreen.dart';
import 'package:sports_betting/Screens/BTLegalDisclaimerScreen.dart';
import 'package:sports_betting/Screens/BTPrivacyScreen.dart';
import 'package:sports_betting/Screens/BTTermsOfUseScreen.dart';
import 'package:flutter/material.dart';

const List<Map<String, dynamic>> info = [
  {"name": "ABOUT US", "icon": Icons.info_outline, "route": BTAboutUsScreen()},
  {
    "name": "CONTACT US",
    "icon": Icons.headset_mic_outlined,
    "route": BTContactUsScreen()
  },
  {
    "name": "PRIVACY",
    "icon": Icons.vpn_key_outlined,
    "route": BTPrivacyScreen()
  },
  {
    "name": "TERMS OF USE",
    "icon": Icons.lightbulb_outline,
    "route": BTTermsOfUseScreen()
  },
  {
    "name": "LEGAL DISCLAIMER",
    "icon": Icons.settings_outlined,
    "route": BTLegalDisclaimerScreen()
  },
];
