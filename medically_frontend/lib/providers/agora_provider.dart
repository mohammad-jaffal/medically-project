import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:medically_frontend/models/call.dart';
import 'package:http/http.dart' as http;

class AgoraProvider with ChangeNotifier {
  var _channelToken;
  var _channelName;
  var _callerID;

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
    print('setting caller id $callerID');
    _callerID = callerID;
  }

  String get getCallerID {
    return _callerID;
  }
}
