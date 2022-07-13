import 'package:shared_preferences/shared_preferences.dart';

class TokenPrefs {
  static const MEDICALLY_TOKEN = "MEDICALLY_TOKEN";
  setToken(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(MEDICALLY_TOKEN, value);
  }
}
