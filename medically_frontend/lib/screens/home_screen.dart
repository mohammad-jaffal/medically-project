import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medically_frontend/models/doctor.dart';
import 'package:medically_frontend/widgets/doctor_card.dart';
import 'package:provider/provider.dart';

import '../providers/doctors_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final ScrollController controller = ScrollController();

    final doctorsProvider = Provider.of<DoctorsProvider>(context);
    var doctors = doctorsProvider.getAllDoctors;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: GridView.builder(
        controller: controller,
        padding: const EdgeInsets.all(10),
        itemCount: doctors.length,
        itemBuilder: (ctx, i) => DoctorCard(doctors[i]),
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
