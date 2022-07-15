import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:medically_frontend/providers/token_provider.dart';
import 'package:medically_frontend/providers/user_provider.dart';
import 'package:medically_frontend/screens/balance_screen.dart';
import 'package:medically_frontend/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../providers/dark_theme_provider.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

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
              Card(
                child: SizedBox(
                  width: double.infinity,
                  // color: Colors.red,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
              // email item
              Card(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 30, 10),
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
                          user.email,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
              // ballance item
              Card(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 4, 30, 4),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              // theme item
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
              // logout item
              Card(
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 30, 10),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          // content: const Text('Are you sure'),
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
