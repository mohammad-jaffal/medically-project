import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class UserRingingScreen extends StatelessWidget {
  const UserRingingScreen({Key? key}) : super(key: key);
  static const routeName = '/user-ringing-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Calling'),
      ),
    );
  }
}
