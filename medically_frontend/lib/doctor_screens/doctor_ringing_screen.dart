import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

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
          children: [
            ElevatedButton(
              onPressed: () {
                print('reject');
              },
              style: ElevatedButton.styleFrom(primary: Colors.red),
              child: Icon(Icons.call_end),
            ),
            ElevatedButton(
              onPressed: () {
                print('accept');
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
