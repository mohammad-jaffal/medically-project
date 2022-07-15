import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class UserCallScreen extends StatelessWidget {
  const UserCallScreen({Key? key}) : super(key: key);
  static const routeName = '/user-call-screen';

  @override
  Widget build(BuildContext context) {
    final doctorId =
        int.parse(ModalRoute.of(context)!.settings.arguments.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(doctorId.toString()),
      ),
      body: Center(
        child: Text('User call screen'),
      ),
    );
  }
}
