import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:medically_frontend/models/call.dart';
import 'package:http/http.dart' as http;
import 'package:medically_frontend/providers/agora_provider.dart';
import 'package:provider/provider.dart';

import '../consts/constants.dart';
import 'doctor_provider.dart';

class CallsProvider with ChangeNotifier {
  String apiConst = Constants.api_const;
  var _calls;
  var _time = null;
  // fetches calls from database based on user id
  Future<void> fetchUserCalls(userID) async {
    var url = Uri.parse('$apiConst/user/get-user-calls');
    var response = await http.post(url, body: {
      'user_id': '$userID',
    });
    _calls = json.decode(response.body)['calls'];
  }

  // fetches calls from database based on doctor id
  Future<void> fetchDoctorCalls(doctorID) async {
    var url = Uri.parse('$apiConst/user/get-doctor-calls');
    var response = await http.post(url, body: {
      'doctor_id': '$doctorID',
    });
    _calls = json.decode(response.body)['calls'];
  }

  // returns list of call objects
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

  // starts the time of the call start
  void setTime(DateTime time) {
    _time = time;
  }

  // ends the time of the call and updates the database with the new call
  Future<void> endTime(DateTime time, BuildContext ctx) async {
    // end call time and register the call in the database
    var docID = Provider.of<DoctorProvider>(ctx, listen: false).getDoctorId;
    var userID = Provider.of<AgoraProvider>(ctx, listen: false).getCallerID;
    if (_time != null) {
      var duration = time.difference(_time).inSeconds;
      // adds the call to the database
      var url = Uri.parse('$apiConst/user/add-call');
      var response = await http.post(url, body: {
        'doctor_id': '$docID',
        'user_id': '$userID',
        'duration': '$duration',
      });
      var cost = 10 * (duration ~/ 60 + 1);
      // transfers balance from user to doctor based on duration of call
      var costUrl = Uri.parse('$apiConst/user/transfer-balance');
      var costResponse = await http.post(costUrl, body: {
        'doctor_id': '$docID',
        'user_id': '$userID',
        'balance': '$cost',
      });
      Provider.of<DoctorProvider>(ctx, listen: false).updateBalance(cost);

      _time = null;
    }
  }
}
