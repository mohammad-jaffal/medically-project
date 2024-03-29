import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:medically_frontend/models/review.dart';
import 'package:http/http.dart' as http;
import '../consts/constants.dart';

class ReviewsProvider with ChangeNotifier {
  String apiConst = Constants.api_const;
  var _reviews;
  // fetchs all reviews for a doctor
  Future<void> fetchReviews(doctorID) async {
    var url = Uri.parse('$apiConst/get-reviews');
    var response = await http.post(url, body: {
      'doctor_id': '$doctorID',
    });
    _reviews = json.decode(response.body)['reviews'];
    notifyListeners();
  }

  //  returns a list of review objects
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
