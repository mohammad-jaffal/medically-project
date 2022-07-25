import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class UserRingingScreen extends StatefulWidget {
  const UserRingingScreen({Key? key}) : super(key: key);
  static const routeName = '/user-ringing-screen';

  @override
  State<UserRingingScreen> createState() => _UserRingingScreenState();
}

class _UserRingingScreenState extends State<UserRingingScreen> {
  @override
  Widget build(BuildContext context) {
    final docImg = ModalRoute.of(context)!.settings.arguments.toString();
    var bytesImage = const Base64Decoder().convert(docImg);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
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
            const Text(
              'Calling . . .',
              style: TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}
