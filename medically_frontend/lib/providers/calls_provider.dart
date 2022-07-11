import 'package:flutter/material.dart';
import 'package:medically_frontend/models/call.dart';

class CallsProvider with ChangeNotifier {
  final List _calls = [
    {
      "id": 1,
      "user_id": 2,
      "doctor_id": 2,
      "duration": 555,
    },
    {
      "id": 1,
      "user_id": 2,
      "doctor_id": 2,
      "duration": 300,
    },
    {
      "id": 1,
      "user_id": 2,
      "doctor_id": 3,
      "duration": 15,
    },
    {
      "id": 1,
      "user_id": 2,
      "doctor_id": 3,
      "duration": 222,
    }
  ];

  List getCallsByUserId(var userID) {
    var _allCalls = _calls.map((e) => Call.fromJson(e)).toList();
    return [..._allCalls];
  }

  List getCallsByDoctorId(var doctorID) {
    var _allCalls = _calls.map((e) => Call.fromJson(e)).toList();
    return [..._allCalls];
  }
}
