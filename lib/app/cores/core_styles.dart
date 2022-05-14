import 'package:flutter/material.dart';

class CoreStyles {
  static TextStyle uTitle =
      TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: Colors.black);

  static InputDecoration buildInputDecoration(String hinttext) {
    return InputDecoration(
        border: InputBorder.none,
        hintText: hinttext,
        labelStyle: const TextStyle(color: Colors.white, fontSize: 20));
  }
}
