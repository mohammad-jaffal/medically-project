import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class TokenProvider with ChangeNotifier {
  var _token;

  void setToken(var token) {
    print(token);
    _token = token;
  }

  Future<bool> validateToken() async {
    var url = Uri.parse('http://10.0.2.2:8000/api/profile');
    var response = await http.post(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token'
    });
    print('Response body: ${response.body}');
    return false;
  }
}
