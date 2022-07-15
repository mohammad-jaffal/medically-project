import 'dart:convert';
import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medically_frontend/providers/reviews_provider.dart';
import 'package:medically_frontend/widgets/review_card.dart';
import 'package:provider/provider.dart';

import '../providers/dark_theme_provider.dart';
import '../providers/doctors_provider.dart';

class DoctorDetailsScreen extends StatefulWidget {
  const DoctorDetailsScreen({Key? key}) : super(key: key);
  static const routeName = '/doctor-details-screen';

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    final docId =
        int.parse(ModalRoute.of(context)!.settings.arguments.toString());
    final doctorsProvider = Provider.of<DoctorsProvider>(context);
    // print(docId);
    var doctor = doctorsProvider.getDoctorByID(docId);
    var bytesImage = const Base64Decoder().convert(doctor.base64Image);
    // get reviews
    final reviewsProvider = Provider.of<ReviewsProvider>(context);
    List reviews = reviewsProvider.getReviews();

    return Scaffold(
      appBar: AppBar(
        title: Text(doctor.name),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.phone,
              size: 35,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Card(
                child: SizedBox(
                  width: double.infinity,
                  // color: Colors.red,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.more_vert,
                                size: 35,
                              )),
                        ],
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.memory(
                          bytesImage,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.email,
                              size: 35,
                              color: themeState.getDarkTheme
                                  ? Colors.white
                                  : Colors.grey[600],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Text(
                                doctor.email,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                        child: SizedBox(
                          width: double.infinity,
                          // color: Colors.red,
                          child: Text(
                            doctor.bio,
                            style: const TextStyle(
                              fontSize: 18,
                              wordSpacing: 2,
                              // letterSpacing: 1,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 20);
                },
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: reviews.length,
                itemBuilder: (context, index) => ReviewCard(
                  reviews[index].rating * 1.0,
                  reviews[index].review_text,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
