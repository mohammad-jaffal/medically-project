import 'package:flutter/material.dart';
import 'package:medically_frontend/models/call.dart';
import 'package:medically_frontend/models/user.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  var _user;
  void setuser(User user) {
    _user = user;
  }

  User get getUser {
    return _user;
  }

  int get getUserId {
    return _user.id;
  }

  Future<void> addBalance(var balance) async {
    _user.balance += balance;
    var url = Uri.parse('http://10.0.2.2:8000/api/user/add-balance');
    var detailsResponse = await http.post(url, body: {
      'user_id': '${_user.id}',
      'balance': '$balance',
    });
    notifyListeners();
  }
}
