import 'package:flutter/material.dart';
import 'package:medically_frontend/models/call.dart';
import 'package:medically_frontend/models/user.dart';

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
}
