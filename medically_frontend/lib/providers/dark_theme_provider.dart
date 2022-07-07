import 'package:flutter/cupertino.dart';

class DarkThemeProvider with ChangeNotifier {
  bool _darkTheme = false;

  bool get getDarkTheme => _darkTheme;
}
