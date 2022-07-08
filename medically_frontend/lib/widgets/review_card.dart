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
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 0, 5),
              child: RatingBarIndicator(
                rating: rating,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 25,
                direction: Axis.horizontal,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: Text(
                review_text,
                style: const TextStyle(
                  fontSize: 16,
                  wordSpacing: 2,
                  // letterSpacing: 1,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),

        // child: Text(doctor.name),
      ),
    );
  }
}
