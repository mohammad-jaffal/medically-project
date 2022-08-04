import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:medically_frontend/doctor_screens/doctor_call_screen.dart';
import 'package:native_notify/native_notify.dart';
import 'package:provider/provider.dart';
import '../providers/agora_provider.dart';

class DoctorRingingScreen extends StatefulWidget {
  const DoctorRingingScreen({Key? key}) : super(key: key);
  static const routeName = '/doctor-ringing-screen';
  @override
  State<DoctorRingingScreen> createState() => _DoctorRingingScreenState();
}

class _DoctorRingingScreenState extends State<DoctorRingingScreen> {
  var callerId;
  var callerName;
  var callerImage;
  bool isRinging = true;

  Future<void> _startTimer() async {
    print('starting timer');
    final agoraProvider = Provider.of<AgoraProvider>(context, listen: false);

    // notify the caller if the call is missed
    await Future.delayed(const Duration(seconds: 10), () {
      if (isRinging) {
        agoraProvider.setInCall(false);
        print('missed');
        NativeNotify.sendIndieNotification(
            1117,
            '0XErqq1jB7rDHxJbpRwhjt',
            '$callerId',
            'Call action',
            'missed',
            null,
            '{"accepted":false, "message":"Call missed"}');
        Navigator.pop(context);
      }
    });
  }

  @override
  void initState() {
    // get caller data
    final agoraProvider = Provider.of<AgoraProvider>(context, listen: false);
    callerId = agoraProvider.getCallerID;
    callerName = agoraProvider.getCallerName;
    callerImage = agoraProvider.getCallerImage;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final agoraProvider = Provider.of<AgoraProvider>(context, listen: false);
    // get caller image
    var bytesImage = const Base64Decoder().convert(callerImage);
    if (isRinging) {
      print('calling start timer');
      _startTimer();
    }
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    callerName,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(200),
              child: Image.memory(
                bytesImage,
                width: MediaQuery.of(context).size.width / 1.5,
                height: MediaQuery.of(context).size.width / 1.5,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // notify the caller when call declined
                    agoraProvider.setInCall(false);
                    print('reject');
                    isRinging = false;
                    NativeNotify.sendIndieNotification(
                        1117,
                        '0XErqq1jB7rDHxJbpRwhjt',
                        '$callerId',
                        'Call action',
                        'rejected',
                        null,
                        '{"accepted":false, "message":"Call declined"}');
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    shape: const CircleBorder(),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.call_end,
                      size: 50,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    isRinging = false;
                    // notify caller when call accepted
                    print('accept');
                    NativeNotify.sendIndieNotification(
                        1117,
                        '0XErqq1jB7rDHxJbpRwhjt',
                        '$callerId',
                        'Call action',
                        'accepted',
                        null,
                        '{"accepted":true}');
                    Navigator.pop(context);
                    // redirect to call screen
                    Navigator.pushNamed(context, DoctorCallScreen.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    shape: const CircleBorder(),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.call_end,
                      size: 50,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
