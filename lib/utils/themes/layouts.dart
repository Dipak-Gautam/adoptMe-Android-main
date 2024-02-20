import 'package:flutter/material.dart';

class Layouts {
  static getTheme(BuildContext context) {
    return Theme.of(context);
  }

  static getSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }
}

class TextFormDeco {
  static InputDecoration createNewAdopted(
      BuildContext context, String labelText) {
    return InputDecoration(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        labelText: labelText);
  }
}
