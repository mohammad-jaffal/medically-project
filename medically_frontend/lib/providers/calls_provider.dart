import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:medically_frontend/models/call.dart';
import 'package:http/http.dart' as http;

class CallsProvider with ChangeNotifier {
  var _calls;
  var _time;

  Future<void> fetchUserCalls(userID) async {
    var url = Uri.parse('http://10.0.2.2:8000/api/user/get-user-calls');
    var response = await http.post(url, body: {
      'user_id': '$userID',
    });
    _calls = json.decode(response.body)['calls'];
  }

  Future<void> fetchDoctorCalls(doctorID) async {
    var url = Uri.parse('http://10.0.2.2:8000/api/user/get-doctor-calls');
    var response = await http.post(url, body: {
      'doctor_id': '$doctorID',
    });
    _calls = json.decode(response.body)['calls'];
  }

  List getCalls() {
    if (_calls != null) {
      var _allCalls = _calls.map((e) => Call.fromJson(e)).toList();
      return [..._allCalls];
    }
    return [];
  }

  void clearCalls() {
    _calls = null;
  }

  void setTime(DateTime time) {
    print(time);
    _time = time;
  }

  void endTime(DateTime time) {
    var diff = time.difference(_time).inSeconds;
    print('...........................$diff................');
  }
}
