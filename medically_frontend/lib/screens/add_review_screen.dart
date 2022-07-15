import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddReviewScreen extends StatelessWidget {
  const AddReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("review"),
      ),
      body: Center(
        child: Text('review screen'),
      ),
    );
  }
}
