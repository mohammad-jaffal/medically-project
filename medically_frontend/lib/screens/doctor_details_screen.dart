import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:medically_frontend/providers/agora_provider.dart';
import 'package:medically_frontend/providers/reviews_provider.dart';
import 'package:medically_frontend/providers/user_provider.dart';
import 'package:medically_frontend/screens/add_review_screen.dart';
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
    // get doctor data
    final docId =
        int.parse(ModalRoute.of(context)!.settings.arguments.toString());
    final doctorsProvider = Provider.of<DoctorsProvider>(context);

    var doctor = doctorsProvider.getDoctorByID(docId);
    var bytesImage = const Base64Decoder().convert(doctor.base64Image);

    final reviewsProvider = Provider.of<ReviewsProvider>(context);
    List reviews = reviewsProvider.getReviews();
    var favIds = doctorsProvider.getFavIds;

    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.getUser;
    final userID = user.id;

    return Scaffold(
      appBar: AppBar(
        title: Text(doctor.name),
        actions: [
          IconButton(
            onPressed: () async {
              // check if doctor is online
              if (doctor.online) {
                if (user.balance < 10) {
                  showDialog(
                    // show alert if not enough balance
                    context: context,
                    builder: (BuildContext ctx) {
                      return AlertDialog(
                        title: const Text('Not enough balance!'),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'OK',
                              style: TextStyle(
                                color: Colors.lightBlue,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  // save doctors channel info
                  Provider.of<AgoraProvider>(context, listen: false)
                      .setData(doctor.channelToken, doctor.channelName);
                  print('calling');
                  // send calling notification to the doctor
                  NativeNotify.sendIndieNotification(
                      1117,
                      '0XErqq1jB7rDHxJbpRwhjt',
                      '$docId',
                      'Phone call',
                      'from $userID',
                      null,
                      '{"userID":"$userID", "userName":"${user.name}", "userImage":"${user.base64Image}"}');
                  // redirect to ringing screen
                  Navigator.pushNamed(context, UserRingingScreen.routeName,
                      arguments: doctor.base64Image.toString());
                }
              } else {
                showDialog(
                  // show doctor is offline aler dialog
                  context: context,
                  builder: (BuildContext ctx) {
                    return AlertDialog(
                      title: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(right: 6.0),
                            child: Icon(Icons.person_off),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Offline :('),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'OK',
                            style: TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            icon: const Icon(
              Icons.phone,
            ),
          ),
          PopupMenuButton(
            enabled: true,
            // get user selected menu option
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
              // check if doctor is favorite
              favIds.contains(docId)
                  ? const PopupMenuItem(
                      value: 1,
                      child: Text('Remove Favorite'),
                    )
                  : const PopupMenuItem(
                      value: 2,
                      child: Text('Add Favorite'),
                    ),
              const PopupMenuItem(
                value: 3,
                child: Text('Write Review'),
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
                            padding: const EdgeInsets.all(2),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.memory(
                                bytesImage,
                                width: MediaQuery.of(context).size.width / 2,
                                height: MediaQuery.of(context).size.width / 2,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                        child: Row(
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
                          child: Text(
                            doctor.bio,
                            style: const TextStyle(
                              fontSize: 18,
                              wordSpacing: 2,
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
