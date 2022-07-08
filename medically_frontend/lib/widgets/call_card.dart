import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medically_frontend/models/call.dart';
import 'package:medically_frontend/models/doctor.dart';
import 'dart:convert';

import 'package:medically_frontend/providers/doctors_provider.dart';
import 'package:provider/provider.dart';

class CallCard extends StatelessWidget {
  final Call call;

  const CallCard(
    this.call,
  );

  @override
  Widget build(BuildContext context) {
    final doctorsProvider = Provider.of<DoctorsProvider>(context);
    final doctor = doctorsProvider.getDoctorByID(call.doctor_id);
    var _bytesImage = Base64Decoder().convert(doctor.base64Image);
    return InkWell(
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            // color: Colors.lightBlue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.memory(
                    _bytesImage,
                    width: 70,
                    height: 70,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                // padding: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.name,
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(call.duration.toString()),
                  ],
                ),
              ),
            ],
          ),
          // child: Text(doctor.name),
        ),
      ),
    );
  }
}
