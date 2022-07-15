import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../providers/doctors_provider.dart';

class UserCallScreen extends StatefulWidget {
  const UserCallScreen({Key? key}) : super(key: key);
  static const routeName = '/user-call-screen';

  @override
  State<UserCallScreen> createState() => _UserCallScreenState();
}

class _UserCallScreenState extends State<UserCallScreen> {
  @override
  Widget build(BuildContext context) {
    final doctorId =
        int.parse(ModalRoute.of(context)!.settings.arguments.toString());
    final doctorsProvider = Provider.of<DoctorsProvider>(context);
    var doctor = doctorsProvider.getDoctorByID(doctorId);
    print(doctor.channelToken);
    return Scaffold(
      appBar: AppBar(
        title: Text(doctorId.toString()),
      ),
      body: Center(
        child: Text(doctor.channelName),
      ),
    );
  }
}
