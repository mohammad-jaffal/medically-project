import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medically_frontend/providers/user_provider.dart';
import 'package:provider/provider.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: Text(user.name.toString()),
      ),
      body: Center(
        child: SwitchListTile(
          title: Text("Theme"),
          secondary: Icon(themeState.getDarkTheme
              ? Icons.dark_mode_outlined
              : Icons.light_mode_outlined),
          onChanged: (bool value) {
            themeState.setDarkTheme = value;
          },
          value: themeState.getDarkTheme,
        ),
      ),
    );
  }
}
