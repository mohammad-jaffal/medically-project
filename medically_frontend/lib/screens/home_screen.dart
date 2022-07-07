import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medically_frontend/models/doctor.dart';
import 'package:medically_frontend/widgets/doctor_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List doctors_list = [];

  @override
  Widget build(BuildContext context) {
    final ScrollController _controller = ScrollController();
    var _doctors = doctors_list.map((e) => Doctor.fromJson(e)).toList();

    print(_doctors[0].name);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: GridView.builder(
        controller: _controller,
        padding: const EdgeInsets.all(10),
        itemCount: _doctors.length,
        itemBuilder: (ctx, i) => DoctorCard(_doctors[i]),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 4 / 1,
          // crossAxisSpacing: 10,
          mainAxisSpacing: 15,
        ),
      ),
    );
  }
}
