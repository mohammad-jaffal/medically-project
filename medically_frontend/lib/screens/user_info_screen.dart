import 'dart:convert';
import 'dart:developer';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medically_frontend/providers/calls_provider.dart';
import 'package:medically_frontend/providers/reviews_provider.dart';
import 'package:medically_frontend/providers/token_provider.dart';
import 'package:medically_frontend/providers/user_provider.dart';
import 'package:medically_frontend/screens/balance_screen.dart';
import 'package:medically_frontend/screens/login_screen.dart';
import 'package:native_notify/native_notify.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../providers/dark_theme_provider.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  // handles picking and updating images
  Future pickImage(ImageSource source) async {
    print('camera');
    final image = await ImagePicker().pickImage(
      source: source,
      maxHeight: 200,
      maxWidth: 200,
    );
    if (image == null) return;
    List<int> imageBytes = await image.readAsBytes() as List<int>;
    String base64Image = base64Encode(imageBytes);
    log(base64Image);
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    // get user data
    final userProvider = Provider.of<UserProvider>(context);
    var user = userProvider.getUser;
    var bytesImage = const Base64Decoder().convert(user.base64Image);

    final tokenProvider = Provider.of<TokenProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name.toString()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              // user profile picture card
              Card(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.memory(
                                bytesImage,
                                width: MediaQuery.of(context).size.width / 2,
                                height: MediaQuery.of(context).size.width / 2,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: FloatingActionButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                          'Select option',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 54, 135, 255),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: [
                                              // camera
                                              InkWell(
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(
                                                        Icons.camera,
                                                        color: themeState
                                                                .getDarkTheme
                                                            ? Colors.white
                                                            : const Color
                                                                    .fromARGB(
                                                                255,
                                                                54,
                                                                135,
                                                                255),
                                                      ),
                                                    ),
                                                    const Text(
                                                      'Camera',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  pickImage(ImageSource.camera);
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              // gallery
                                              InkWell(
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(
                                                        Icons.image,
                                                        color: themeState
                                                                .getDarkTheme
                                                            ? Colors.white
                                                            : const Color
                                                                    .fromARGB(
                                                                255,
                                                                54,
                                                                135,
                                                                255),
                                                      ),
                                                    ),
                                                    const Text(
                                                      'Gallery',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  pickImage(
                                                      ImageSource.gallery);
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              // remove image
                                              InkWell(
                                                child: Row(
                                                  children: const [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Icon(
                                                        Icons.remove_circle,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Remove',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.red),
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Icon(
                                  Icons.add_a_photo_rounded,
                                  color: themeState.getDarkTheme
                                      ? Colors.white
                                      : Colors.grey[600],
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                          user.email,
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
                  padding: const EdgeInsets.fromLTRB(20, 4, 30, 4),
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
                          user.balance.toString(),
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, BalanceScreen.routeName);
                        },
                        icon: Icon(
                          Icons.add,
                          color: themeState.getDarkTheme
                              ? Colors.white
                              : Colors.grey[600],
                          size: 35,
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
