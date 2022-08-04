import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:medically_frontend/providers/doctor_provider.dart';
import 'package:medically_frontend/providers/doctors_provider.dart';
import 'package:medically_frontend/providers/reviews_provider.dart';
import 'package:medically_frontend/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../consts/constants.dart';
import '../providers/dark_theme_provider.dart';
import 'package:http/http.dart' as http;

class UpdateBioScreen extends StatefulWidget {
  UpdateBioScreen({Key? key}) : super(key: key);
  static const routeName = '/update-bio-screen';

  @override
  State<UpdateBioScreen> createState() => _UpdateBioScreenState();
}

class _UpdateBioScreenState extends State<UpdateBioScreen> {
  String apiConst = Constants.api_const;
  final myController = TextEditingController();

  // updates bio in database and in provider
  Future<void> _updateBio(var doctorID) async {
    if (myController.text == '') {
      print('do nothing');
    } else {
      var url = Uri.parse('$apiConst/update-bio');
      var response = await http.post(url, body: {
        'doctor_id': '$doctorID',
        'bio': myController.text,
      });
      // update the bio locally only if its updated in db
      if (json.decode(response.body)['success']) {
        Provider.of<DoctorProvider>(context, listen: false)
            .updateBio(myController.text);
        Navigator.pop(context);
      }
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
    // get doctor id
    var doctorID =
        Provider.of<DoctorProvider>(context, listen: false).getDoctorId;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Bio"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: TextField(
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
                    hintText: 'Write the bio here...',
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
                      _updateBio(doctorID);
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
