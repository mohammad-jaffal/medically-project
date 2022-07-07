import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class DoctorDetailsScreen extends StatelessWidget {
  const DoctorDetailsScreen({Key? key}) : super(key: key);
  static const routeName = '/doctor-details-screen';

  @override
  Widget build(BuildContext context) {
    final docId = ModalRoute.of(context)!.settings.arguments.toString();
    return Scaffold(
      appBar: AppBar(title: Text(docId)),
      body: Center(child: Text('doctors details')),
    );
  }
}
