import 'dart:convert';
import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
    var _bytesImage = Base64Decoder().convert(doctor.base64Image);
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
                child: Container(
                  width: double.infinity,
                  // color: Colors.red,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.more_vert)),
                        ],
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.memory(
                          _bytesImage,
                          width: 150,
                          height: 150,
                          fit: BoxFit.fill,
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
            ],
          ),
        ),
      ),
    );
  }
}


// child: ClipRRect(
//                     borderRadius: BorderRadius.circular(100),
//                     child: Image.memory(
//                       _bytesImage,
//                       width: 70,
//                       height: 70,
//                       fit: BoxFit.fill,
//                     ),
//                   ),