import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../providers/dark_theme_provider.dart';
import '../providers/doctor_provider.dart';
import '../providers/doctor_provider.dart';

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
    var doctor = doctorProvider.getDoctor;
    var bytesImage = const Base64Decoder().convert(doctor.base64Image);

    return Scaffold(
      appBar: AppBar(
        title: Text(doctor.name.toString()),
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
                          doctor.email,
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
                          doctor.balance.toString(),
                          style: const TextStyle(fontSize: 20),
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
                    print('logout');
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
