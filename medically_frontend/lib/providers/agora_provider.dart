import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:medically_frontend/models/call.dart';
import 'package:http/http.dart' as http;

class AgoraProvider with ChangeNotifier {
  var _channelToken;
  var _channelName;
  var _callerID;
  var _callerName;
  var _callerImage;
  bool _inCall = false;

  void setData(var token, var name) {
    _channelToken = token;
    _channelName = name;
  }

  String get getToken {
    return _channelToken;
  }

  String get getTName {
    return _channelName;
  }

  void setCallerID(var callerID) {
    _callerID = callerID;
  }

  String get getCallerID {
    return _callerID;
  }

  void setInCall(bool inCall) {
    _inCall = inCall;
    notifyListeners();
  }

  bool get getInCall {
    return _inCall;
  }

  void setCallerName(var callerName) {
    _callerName = callerName;
  }

  String get getCallerName {
    return _callerName;
  }

  void setCallerImage(var callerImg) {
    _callerImage = callerImg;
  }

  String get getCallerImage {
    return _callerImage;
  }
}
