import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class UserCallScreen extends StatelessWidget {
  const UserCallScreen({Key? key}) : super(key: key);
  static const routeName = '/user-call-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('User call screen'),
      ),
    );
  }
}
