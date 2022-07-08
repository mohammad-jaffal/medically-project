import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

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