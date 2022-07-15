import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medically_frontend/models/call.dart';
import 'package:medically_frontend/models/review.dart';

import 'package:http/http.dart' as http;

class ReviewsProvider with ChangeNotifier {
  var _reviews;

  Future<void> fetchReviews(doctorID) async {
    var url = Uri.parse('http://10.0.2.2:8000/api/get-reviews');
    var response = await http.post(url, body: {
      'doctor_id': '$doctorID',
    });
    _reviews = json.decode(response.body)['reviews'];
    notifyListeners();
  }

  List getReviews() {
    if (_reviews != null) {
      var _allReviews = _reviews.map((e) => Review.fromJson(e)).toList();
      return [..._allReviews];
    }
    return [];
  }

  void clearReviews() {
    _reviews = null;
  }
}
