import 'dart:convert';
import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medically_frontend/providers/agora_provider.dart';
import 'package:medically_frontend/providers/reviews_provider.dart';
import 'package:medically_frontend/providers/user_provider.dart';
import 'package:medically_frontend/screens/add_review_screen.dart';
import 'package:medically_frontend/screens/user_call_screen.dart';
import 'package:medically_frontend/screens/user_ringing_screen.dart';
import 'package:medically_frontend/widgets/review_card.dart';
import 'package:provider/provider.dart';

import '../providers/dark_theme_provider.dart';
import '../providers/doctors_provider.dart';
import 'package:native_notify/native_notify.dart';

class DoctorDetailsScreen extends StatefulWidget {
  const DoctorDetailsScreen({Key? key}) : super(key: key);
  static const routeName = '/doctor-details-screen';

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  void addFavorite(var userID, var doctorID) {
    Provider.of<DoctorsProvider>(context, listen: false)
        .addFavorite(userID, doctorID);
  }

  void removeFavorite(var userID, var doctorID) {
    Provider.of<DoctorsProvider>(context, listen: false)
        .removeFavorite(userID, doctorID);
  }

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
    var favIds = doctorsProvider.getFavIds;

    final userProvider = Provider.of<UserProvider>(context);
    final userID = userProvider.getUserId;
    // print(favIds);

    return Scaffold(
      appBar: AppBar(
        title: Text(doctor.name),
        actions: [
          IconButton(
            onPressed: () async {
              Provider.of<AgoraProvider>(context, listen: false)
                  .setData(doctor.channelToken, doctor.channelName);
              print('calling');
              NativeNotify.sendIndieNotification(
                  1117,
                  '0XErqq1jB7rDHxJbpRwhjt',
                  '$docId',
                  'Phone calls',
                  'from $userID',
                  null,
                  '{"userID":"$userID"}');
              Navigator.pushNamed(context, UserRingingScreen.routeName);
              // Navigator.pushNamed(context, UserCallScreen.routeName);
            },
            icon: const Icon(
              Icons.phone,
              // size: 35,
            ),
          ),
          PopupMenuButton(
            enabled: true,
            onSelected: (value) {
              if (value == 1) {
                removeFavorite(userID, docId);
              }
              if (value == 2) {
                addFavorite(userID, docId);
              }
              if (value == 3) {
                Navigator.pushNamed(
                  context,
                  AddReviewScreen.routeName,
                  arguments: doctor.id,
                );
              }
            },
            itemBuilder: (context) => [
              favIds.contains(docId)
                  ? const PopupMenuItem(
                      value: 1,
                      child: Text('Remove'),
                    )
                  : const PopupMenuItem(
                      value: 2,
                      child: Text('Add'),
                    ),
              const PopupMenuItem(
                value: 3,
                child: Text('Review'),
              ),
            ],
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: doctor.online ? Colors.green : Colors.grey,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(1),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.memory(
                                bytesImage,
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
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
              reviews.isEmpty
                  ? const Center(child: Text('No Reviews Found!'))
                  : ListView.separated(
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
