import 'dart:ui';

import 'package:flutter/material.dart';

class Globals {

  static Color mainColor = Color(0xff6e1323);
  static Color buttonColor = Color(0xffc71e38);
  static Color unselectButtonColor = Color(0xffA4777E);

  static String token = "";
  static String name = "";
  static String email = "";

  static BoxDecoration boxRoundedDecoration(
      {Color bgColor = Colors.white,
      Color borderColor = Colors.grey,
      BorderRadiusGeometry borderRadius =
          const BorderRadius.all(Radius.circular(10))}) {
    return BoxDecoration(
        color: bgColor,
        borderRadius: borderRadius,
        border: Border.all(color: borderColor));
  }
}
