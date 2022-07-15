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

class CallCard extends StatelessWidget {
  final Call call;

  const CallCard(
    this.call,
  );

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    var _bytesImage = Base64Decoder().convert(call.call_image);
    double width = MediaQuery.of(context).size.width;
    return Card(
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
            // color: Colors.lightBlue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                // padding: const EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.fromLTRB(30, 15, 0, 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      call.name,
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(_printDuration(Duration(seconds: call.duration))),
                  ],
                ),
              ),
              const Expanded(child: SizedBox()),
              Padding(
                padding: EdgeInsets.only(right: 11),
                child: IconButton(
                  icon: Icon(Icons.phone),
                  color:
                      themeState.getDarkTheme ? Colors.white : Colors.grey[600],
                  iconSize: 30,
                  onPressed: () {
                    print('call ${call.doctor_id}');
                  },
                ),
              )
            ],
          ),
          // child: Text(doctor.name),
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
