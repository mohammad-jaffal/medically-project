import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medically_frontend/doctor_screens/doctor_call_screen.dart';

class DoctorRingingScreen extends StatefulWidget {
  const DoctorRingingScreen({Key? key}) : super(key: key);
  static const routeName = '/doctor-ringing-screen';
  @override
  State<DoctorRingingScreen> createState() => _DoctorRingingScreenState();
}

class _DoctorRingingScreenState extends State<DoctorRingingScreen> {
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
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(primary: Colors.red),
              child: Icon(Icons.call_end),
            ),
            ElevatedButton(
              onPressed: () {
                print('accept');
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
