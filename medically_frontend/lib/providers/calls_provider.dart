import 'package:flutter/material.dart';

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

  List get getCalls {
    return [..._calls];
  }
}