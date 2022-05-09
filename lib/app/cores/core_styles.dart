import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rsm_flutter_get_cli/app/cores/core_colors.dart';

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
