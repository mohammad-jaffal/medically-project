import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medically_frontend/doctor_screens/doctor_call_screen.dart';
import 'package:medically_frontend/providers/calls_provider.dart';
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
  bool isRinging = true;

  Future<void> _startTimer() async {
    print('starting timer');
    final agoraProvider = Provider.of<AgoraProvider>(context, listen: false);

    // agoraProvider.setInCall(true);
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
            '{"accepted":false, "message":"call missed"}');
        Navigator.pop(context);
      }
    });
  }

  @override
  void initState() {
    final agoraProvider = Provider.of<AgoraProvider>(context, listen: false);
    callerId = agoraProvider.getCallerID;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final agoraProvider = Provider.of<AgoraProvider>(context, listen: false);
    if (isRinging) {
      print('calling start timer');
      _startTimer();
    }
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
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
                    '{"accepted":false, "message":"call declined"}');
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(primary: Colors.red),
              child: Icon(Icons.call_end),
            ),
            ElevatedButton(
              onPressed: () {
                isRinging = false;

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
                Navigator.pushNamed(context, DoctorCallScreen.routeName);
              },
              style: ElevatedButton.styleFrom(primary: Colors.green),
              child: Icon(Icons.call_end),
            ),
          ],
        ),
      ),
    );
  }
}
