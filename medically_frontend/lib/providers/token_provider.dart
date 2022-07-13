import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:medically_frontend/models/user.dart';
import 'package:medically_frontend/providers/user_provider.dart';
import 'package:medically_frontend/services/token_prefs.dart';

class TokenProvider with ChangeNotifier {
  TokenPrefs tokenPrefs = TokenPrefs();
  var _token;

  void setToken(var token) {
    _token = token;
    tokenPrefs.setToken(token);
    // validateToken();
  }

  Future<String> validateToken() async {
    var url = Uri.parse('http://10.0.2.2:8000/api/profile');
    var response = await http.post(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token'
    });

    return response.body;
  }

  String get getToken {
    return _token;
  }
}
