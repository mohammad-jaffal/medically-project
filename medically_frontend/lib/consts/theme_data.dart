import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor:
          isDarkTheme ? const Color(0xFF00001a) : const Color(0xFFFFFFFF),
      primaryColor: isDarkTheme
          ? const Color(0xFF00001a)
          : const Color.fromARGB(255, 54, 135, 255),
      // Color.fromARGB(255, 0, 4, 255),
      colorScheme: ThemeData().colorScheme.copyWith(
            secondary:
                isDarkTheme ? const Color(0xff1a1f3c) : const Color(0xffe8fdfd),
            brightness: isDarkTheme ? Brightness.dark : Brightness.light,
          ),

      cardColor: isDarkTheme
          ? Color.fromARGB(255, 18, 23, 77)
          : const Color.fromARGB(255, 255, 255, 255),
      canvasColor: isDarkTheme
          ? Color.fromARGB(255, 9, 11, 44)
          : const Color.fromARGB(255, 54, 135, 255),
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme
              ? const ColorScheme.dark()
              : const ColorScheme.light()),
      // app bar theme
      appBarTheme: AppBarTheme(
        backgroundColor: isDarkTheme
            ? Color.fromARGB(255, 9, 11, 44)
            : const Color.fromARGB(255, 54, 135, 255),
        // isDarkTheme ? Colors.black : const Color.fromARGB(255, 0, 4, 255),
        // This will be applied to the "back" icon
        iconTheme: IconThemeData(color: Colors.white),
        // This will be applied to the action icon buttons that locates on the right side
        // actionsIconTheme: IconThemeData(color: Colors.white),
        // centerTitle: true,
        // elevation: 15,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        primary: isDarkTheme
            ? const Color(0xff0a0d2c)
            : const Color.fromARGB(255, 54, 135, 255),
      )),
    );
  }
}
