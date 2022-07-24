import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medically_frontend/providers/token_provider.dart';
import 'package:medically_frontend/screens/login_screen.dart';
import 'package:native_notify/native_notify.dart';
import 'package:provider/provider.dart';

import '../providers/calls_provider.dart';
import '../providers/dark_theme_provider.dart';
import '../providers/doctor_provider.dart';
import '../providers/doctor_provider.dart';
import 'package:http/http.dart' as http;

import '../providers/reviews_provider.dart';

class DoctorInfoScreen extends StatefulWidget {
  const DoctorInfoScreen({Key? key}) : super(key: key);

  @override
  State<DoctorInfoScreen> createState() => _DoctorInfoScreenState();
}

class _DoctorInfoScreenState extends State<DoctorInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    final doctorProvider = Provider.of<DoctorProvider>(context);
    // get the doctor object
    var doctor = doctorProvider.getDoctor;
    var bytesImage = const Base64Decoder().convert(doctor.base64Image);

    final tokenProvider = Provider.of<TokenProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(doctor.name.toString()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              // doctor profile picture card
              Card(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 5),
              // online status card
              Card(
                child: SwitchListTile(
                  title: Text(doctor.online ? "Online" : "Offline"),
                  secondary: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                    child: Icon(doctor.online
                        ? Icons.person_outline_outlined
                        : Icons.person_off_outlined),
                  ),
                  onChanged: (bool value) async {
                    var url = Uri.parse(
                        'http://10.0.2.2:8000/api/user/set-doctor-status');
                    var response = await http.post(url, body: {
                      'doctor_id': '${doctor.id}',
                      'status': value ? '1' : '0',
                    });
                    if (json.decode(response.body)['success']) {
                      doctorProvider.setOnline(value);
                    }
                  },
                  value: doctor.online,
                ),
              ),

              const SizedBox(height: 5),
              // email item card
              Card(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 30, 10),
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
              ),
              const SizedBox(height: 5),
              // rating item card
              Card(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 30, 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star_border,
                        size: 35,
                        color: themeState.getDarkTheme
                            ? Colors.white
                            : Colors.grey[600],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(
                          doctor.rating.toString(),
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
              // ballance item card
              Card(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 30, 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.monetization_on_outlined,
                        size: 35,
                        color: themeState.getDarkTheme
                            ? Colors.white
                            : Colors.grey[600],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(
                          doctor.balance.toString(),
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
              // theme item card
              Card(
                child: SwitchListTile(
                  title: Text(
                      themeState.getDarkTheme ? "Dark mode" : "Light mode"),
                  secondary: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                    child: Icon(themeState.getDarkTheme
                        ? Icons.dark_mode_outlined
                        : Icons.light_mode_outlined),
                  ),
                  onChanged: (bool value) {
                    themeState.setDarkTheme = value;
                  },
                  value: themeState.getDarkTheme,
                ),
              ),
              const SizedBox(height: 5),
              // logout item card
              Card(
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 30, 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          size: 35,
                          color: themeState.getDarkTheme
                              ? Colors.white
                              : Colors.grey[600],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Text(
                            'Log out',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    // show "are u sure ?" dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext ctx) {
                        return AlertDialog(
                          title: Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(right: 6.0),
                                child: Icon(Icons.exit_to_app),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Sure ?'),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'NO',
                                style: TextStyle(
                                  color: Colors.lightBlue,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // destroy token, clear data, clear notification subject id
                                tokenProvider.setToken('none');
                                Provider.of<CallsProvider>(context,
                                        listen: false)
                                    .clearCalls();
                                Provider.of<ReviewsProvider>(context,
                                        listen: false)
                                    .clearReviews();
                                NativeNotify.registerIndieID('-');
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    LoginScreen.routeName,
                                    (Route<dynamic> route) => false);
                              },
                              child: const Text(
                                'YES',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
