import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:medically_frontend/models/user.dart';
import 'package:medically_frontend/providers/user_provider.dart';

class TokenProvider with ChangeNotifier {
  var _token;

  void setToken(var token) {
    _token = token;
    validateToken();
  }

  Future<String> validateToken() async {
    var url = Uri.parse('http://10.0.2.2:8000/api/profile');
    var response = await http.post(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token'
    });
    if (json.decode(response.body)['message'] == 'Unauthenticated.') {
      return 'Unauthenticated';
    }
    print('Response body: ${json.decode(response.body)['id']}');
    var u = User(
      id: json.decode(response.body)['id'],
      name: json.decode(response.body)['name'],
      email: json.decode(response.body)['email'],
      base64Image: json.decode(response.body)['profile_picture'],
      balance: json.decode(response.body)['balance'],
      type: json.decode(response.body)['type'],
    );

    UserProvider().setuser(u);
    return 'false';
  }
}
