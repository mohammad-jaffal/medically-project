import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:medically_frontend/models/call.dart';
import 'package:http/http.dart' as http;

class AgoraProvider with ChangeNotifier {
  var _channelToken;
  var _channelName;

  set setToken(var token) {
    _channelToken = token;
  }

  set setName(var name) {
    _channelName = name;
  }

  String get getToken {
    return _channelToken;
  }

  String get getTName {
    return _channelName;
  }
}
