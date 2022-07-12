import 'package:flutter/cupertino.dart';

class TokenProvider with ChangeNotifier {
  var _token;

  void set setToken(var token) {
    _token = token;
  }
}
