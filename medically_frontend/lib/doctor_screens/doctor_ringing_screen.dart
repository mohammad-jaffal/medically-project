import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
  @override
  void initState() {
    callerId = Provider.of<AgoraProvider>(context, listen: false).getCallerID;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                print('reject');
                NativeNotify.sendIndieNotification(
                    1117,
                    '0XErqq1jB7rDHxJbpRwhjt',
                    '$callerId',
                    'Phone calls',
                    'rejected',
                    null,
                    '{"accepted":false}');
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(primary: Colors.red),
              child: Icon(Icons.call_end),
            ),
            ElevatedButton(
              onPressed: () {
                print('accept');
                NativeNotify.sendIndieNotification(
                    1117,
                    '0XErqq1jB7rDHxJbpRwhjt',
                    '$callerId',
                    'Phone calls',
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
