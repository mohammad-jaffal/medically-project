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
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('All Doctors');
  @override
  Widget build(BuildContext context) {
    final ScrollController controller = ScrollController();
    final doctorsProvider = Provider.of<DoctorsProvider>(context);
    var alldoctors = doctorsProvider.getAllDoctors;
    var _doctors = alldoctors;
    var temp = [];
    return Scaffold(
      appBar: AppBar(
        title: customSearchBar,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (customIcon.icon == Icons.search) {
                  customIcon = const Icon(Icons.cancel);
                  customSearchBar = ListTile(
                    title: TextField(
                      onChanged: (value) {
                        for (var i = 0; i < alldoctors.length; i++) {
                          if (alldoctors[i].name.contains(value)) {
                            print(alldoctors[i].name);
                          }
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: 'Enter doctor\'s name...',
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      autofocus: true,
                    ),
                  );
                } else {
                  customIcon = const Icon(Icons.search);
                  customSearchBar = const Text('All Doctors');
                }
              });
            },
            icon: customIcon,
          ),
        ],
      ),
      body: GridView.builder(
        controller: controller,
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
