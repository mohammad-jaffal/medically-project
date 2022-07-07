import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor:
          isDarkTheme ? const Color(0xFF00001a) : const Color(0xFFFFFFFF),
      primaryColor: const Color(0x000500ff),
    );
  }
}
