import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:medically_frontend/models/call.dart';
import 'package:http/http.dart' as http;

class CallsProvider with ChangeNotifier {
  var _userCalls;

  Future<void> fetchUserCalls(userID) async {
    var url = Uri.parse('http://10.0.2.2:8000/api/user/get-user-calls');
    var response = await http.post(url, body: {
      'user_id': '$userID',
    });
    _userCalls = json.decode(response.body)['calls'];
  }

  List getUserCalls(var userID) {
    var _allCalls = _userCalls.map((e) => Call.fromJson(e)).toList();
    return [..._allCalls];
  }

  List getDoctorCalls(var doctorID) {
    var _allCalls = _userCalls.map((e) => Call.fromJson(e)).toList();
    return [..._allCalls];
  }
}
