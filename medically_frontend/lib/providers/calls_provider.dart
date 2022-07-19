import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:medically_frontend/models/call.dart';
import 'package:http/http.dart' as http;
import 'package:medically_frontend/providers/agora_provider.dart';
import 'package:provider/provider.dart';

import 'doctor_provider.dart';

class CallsProvider with ChangeNotifier {
  var _calls;
  var _time = null;

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
    _time = time;
  }

  Future<void> endTime(DateTime time, BuildContext ctx) async {
    // end call time and register the call in the database
    var docID = Provider.of<DoctorProvider>(ctx, listen: false).getDoctorId;
    var userID = Provider.of<AgoraProvider>(ctx, listen: false).getCallerID;
    if (_time != null) {
      var duration = time.difference(_time).inSeconds;
      var url = Uri.parse('http://10.0.2.2:8000/api/user/add-call');
      var response = await http.post(url, body: {
        'doctor_id': '$docID',
        'user_id': '$userID',
        'duration': '$duration',
      });
      var cost = 10 * (duration ~/ 60 + 1);
      print(
          '----------------------------------------------------------------------------------------$cost');

      var costUrl = Uri.parse('http://10.0.2.2:8000/api/user/transfer-balance');
      var costResponse = await http.post(costUrl, body: {
        'doctor_id': '$docID',
        'user_id': '$userID',
        'balance': '$cost',
      });

      _time = null;
    }
  }
}
