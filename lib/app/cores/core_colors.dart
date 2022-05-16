import 'package:flutter/material.dart';

class CoreColor {
  static Color primary = Color.fromARGB(255, 255, 0, 0);
  static Color primarySoft = Color.fromARGB(255, 85, 11, 11);
  static Color primaryExtraSoft = Color(0xFFEEF4F4);
  static Color secondary = Color(0xFFEDE5CC);
  static Color whiteSoft = Color(0xFFF8F8F8);
  static Color kTextColor = Color(0xFF757575);
  static Color gradient1 = Color(0xFFDC2E35);
  static Color gradient2 = Color(0xFFF65537);
  static Color greyColor2 = Color(0xFFE5E5E5);
  static Color kHintTextColor = Color(0xFFBB9B9B9);

  static LinearGradient bottomShadow = LinearGradient(
      colors: [gradient1, gradient2],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);
  static LinearGradient bottomShadowShoft = LinearGradient(colors: [
    Color(0xFF107873).withOpacity(0.2),
    Color(0xFF107873).withOpacity(0.2)
  ], begin: Alignment.bottomCenter, end: Alignment.topCenter);
  static LinearGradient linearBlackBottom = LinearGradient(
      colors: [Colors.black.withOpacity(0.45), Colors.black.withOpacity(0)],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter);
  static LinearGradient linearBlackTop = LinearGradient(
      colors: [Colors.black.withOpacity(0.5), Colors.transparent],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
}
