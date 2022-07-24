import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medically_frontend/models/call.dart';
import 'package:medically_frontend/models/doctor.dart';
import 'dart:convert';

import 'package:medically_frontend/providers/doctors_provider.dart';
import 'package:medically_frontend/screens/doctor_details_screen.dart';
import 'package:medically_frontend/screens/user_call_screen.dart';
import 'package:provider/provider.dart';

import '../providers/agora_provider.dart';
import '../providers/dark_theme_provider.dart';

import 'package:intl/intl.dart';

class CallCard extends StatelessWidget {
  final Call call;

  const CallCard(
    this.call,
  );

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    var _bytesImage = Base64Decoder().convert(call.call_image);
    print(call.date);
    // final DateTime now = DateTime(call.date);
    final call_date = DateFormat('yyyy-MM-dd HH:mm:ss').parse(call.date);
    final DateFormat formatter = DateFormat("MMMM d, HH:mm");
    final String formatted = formatter.format(call_date);
    print(formatted);

    return Card(
      child: InkWell(
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
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 15, 0, 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      call.name,
                      style: const TextStyle(fontSize: 18),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(formatted + "  -  "),
                        Text(_printDuration(Duration(seconds: call.duration))),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            DoctorDetailsScreen.routeName,
            arguments: call.doctor_id,
          );
        },
      ),
    );
  }
}
