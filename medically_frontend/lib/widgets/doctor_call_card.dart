import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medically_frontend/models/call.dart';
import 'package:medically_frontend/models/doctor.dart';
import 'dart:convert';

import 'package:medically_frontend/providers/doctors_provider.dart';
import 'package:medically_frontend/screens/doctor_details_screen.dart';
import 'package:provider/provider.dart';

import '../providers/dark_theme_provider.dart';
import 'package:intl/intl.dart';

class DoctorCallCard extends StatelessWidget {
  final Call call;

  const DoctorCallCard(
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
    final db_date = DateFormat('yyyy-MM-dd HH:mm:ss').parse(call.date);
    final DateFormat formatter = DateFormat("MMMM d, HH:mm");
    final String call_date = formatter.format(db_date);
    return Card(
      child: Container(
        decoration: BoxDecoration(
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
              padding: const EdgeInsets.fromLTRB(30, 15, 0, 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    call.name,
                    style: const TextStyle(fontSize: 18),
                  ),
                  Row(
                    children: [
                      Text(call_date + "  -  "),
                      Text(_printDuration(Duration(seconds: call.duration))),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
