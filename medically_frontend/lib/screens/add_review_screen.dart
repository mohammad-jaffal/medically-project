import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:medically_frontend/providers/reviews_provider.dart';
import 'package:medically_frontend/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../providers/dark_theme_provider.dart';
import 'package:http/http.dart' as http;

class AddReviewScreen extends StatefulWidget {
  AddReviewScreen({Key? key}) : super(key: key);
  static const routeName = '/add-review-screen';

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  var _rating = 0;
  final myController = TextEditingController();

  Future<void> _sendReview(var userID, var doctorID) async {
    if (_rating == 0 || myController.text == '') {
      print('do nothing');
    } else {
      var url = Uri.parse('http://10.0.2.2:8000/api/user/add-review');
      var response = await http.post(url, body: {
        'user_id': '$userID',
        'doctor_id': '$doctorID',
        'review_text': myController.text,
        'rating': '$_rating',
      });
      print(json.decode(response.body)['avg']);
      await Provider.of<ReviewsProvider>(context, listen: false)
          .fetchReviews(doctorID);
      // Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    var userID = Provider.of<UserProvider>(context, listen: false).getUserId;
    final doctorId =
        int.parse(ModalRoute.of(context)!.settings.arguments.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text("review"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            RatingBarIndicator(
              rating: double.parse('$_rating'),
              itemBuilder: (context, index) => IconButton(
                onPressed: () {
                  setState(() {
                    _rating = index + 1;
                  });
                },
                icon: const Icon(Icons.star),
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 70,
              direction: Axis.horizontal,
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: TextField(
                  // keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  minLines: 1,
                  maxLines: 6,
                  controller: myController,
                  style: const TextStyle(
                    fontSize: 20,
                    wordSpacing: 1,
                    height: 1.5,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Write the review here...',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Expanded(child: SizedBox()),
                  FloatingActionButton(
                    onPressed: () {
                      _sendReview(userID, doctorId);
                    },
                    backgroundColor: themeState.getDarkTheme
                        ? const Color(0xff0a0d2c)
                        : const Color.fromARGB(255, 54, 135, 255),
                    child: const Icon(
                      Icons.send,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
