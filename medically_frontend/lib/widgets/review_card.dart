import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:medically_frontend/providers/reviews_provider.dart';
import 'package:provider/provider.dart';

class ReviewCard extends StatelessWidget {
  String name = '';
  final double rating;
  final String review_text;
  ReviewCard(this.rating, this.review_text, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          // color: Colors.lightBlue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RatingBarIndicator(
              rating: rating,
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 20,
              direction: Axis.horizontal,
            ),
            Text(review_text),
          ],
        ),

        // child: Text(doctor.name),
      ),
    );
  }
}
