// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';

extension  ColorExtension on String {
  toColor(){
    var hexColor = this.replaceAll("#", "");
    if(hexColor.length == 6){
      hexColor = '99$hexColor';
    }
    if(hexColor.length == 8){
      return Color(int.parse("0x$hexColor"));
    }
  }
}

extension E on String {
  String lastChars(int n) => substring(length - n);
}