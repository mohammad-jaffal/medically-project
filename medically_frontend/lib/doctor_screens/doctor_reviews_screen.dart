import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../providers/doctors_provider.dart';
import '../providers/reviews_provider.dart';
import '../widgets/review_card.dart';

class DoctorReviewsScreen extends StatefulWidget {
  const DoctorReviewsScreen({Key? key}) : super(key: key);

  @override
  State<DoctorReviewsScreen> createState() => _DoctorReviewsScreenState();
}

class _DoctorReviewsScreenState extends State<DoctorReviewsScreen> {
  @override
  Widget build(BuildContext context) {
    final docId = 1;
    // get reviews
    final reviewsProvider = Provider.of<ReviewsProvider>(context);
    List reviews = reviewsProvider.getReviewsByDocID(docId);
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews'),
      ),
      body: ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (context, index) => ReviewCard(
          reviews[index].rating * 1.0,
          reviews[index].review_text,
        ),
      ),
    );
  }
}
