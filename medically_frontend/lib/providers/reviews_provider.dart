import 'package:flutter/material.dart';
import 'package:medically_frontend/models/call.dart';
import 'package:medically_frontend/models/review.dart';

class ReviewsProvider with ChangeNotifier {
  final List _reviews = [
    {
      "id": 1,
      "user_id": 2,
      "doctor_id": 2,
      "rating": 4,
      "review_text":
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    },
    {
      "id": 1,
      "user_id": 2,
      "doctor_id": 2,
      "rating": 4,
      "review_text":
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    },
    {
      "id": 1,
      "user_id": 2,
      "doctor_id": 2,
      "rating": 4,
      "review_text":
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    },
    {
      "id": 1,
      "user_id": 2,
      "doctor_id": 2,
      "rating": 4,
      "review_text":
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    },
    {
      "id": 1,
      "user_id": 2,
      "doctor_id": 2,
      "rating": 4,
      "review_text":
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    },
  ];

  List getReviewsByDocID() {
    var _allReviews = _reviews.map((e) => Review.fromJson(e)).toList();
    return [..._allReviews];
  }
}
