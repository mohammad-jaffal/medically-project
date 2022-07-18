import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:medically_frontend/models/doctor.dart';
import 'dart:convert';

import 'package:medically_frontend/screens/doctor_details_screen.dart';
import 'package:provider/provider.dart';

import '../providers/reviews_provider.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;

  const DoctorCard(
    this.doctor,
  );

  @override
  Widget build(BuildContext context) {
    var _bytesImage = Base64Decoder().convert(doctor.base64Image);

    return Card(
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
            // color: Colors.lightBlue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: doctor.online ? Colors.green : Colors.grey,
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.memory(
                        _bytesImage,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.name,
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text('domain ${doctor.domainId}'),
                    RatingBarIndicator(
                      rating: doctor.rating,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 20,
                      direction: Axis.horizontal,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () async {
          // navigate to doctor details screen
          final reviewsProvider =
              Provider.of<ReviewsProvider>(context, listen: false);
          await reviewsProvider.fetchReviews(doctor.id);
          Navigator.pushNamed(
            context,
            DoctorDetailsScreen.routeName,
            arguments: doctor.id,
          );
        },
      ),
    );
  }
}
