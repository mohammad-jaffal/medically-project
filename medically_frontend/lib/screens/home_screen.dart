import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medically_frontend/models/doctor.dart';
import 'package:medically_frontend/widgets/doctor_card.dart';
import 'package:provider/provider.dart';

import '../providers/dark_theme_provider.dart';
import '../providers/doctors_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchNode = FocusNode();
  var searchText = '';
  var domainId = 0;
  @override
  void dispose() {
    searchNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final doctorsProvider = Provider.of<DoctorsProvider>(context);
    final themeState = Provider.of<DarkThemeProvider>(context);
    var _doctors = doctorsProvider.getDoctors(searchText, domainId);
    var _domains = doctorsProvider.getDomains;
    // print(_domains[1]['domain_name']);
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: TextField(
            focusNode: searchNode,
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
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
            // autofocus: true,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              searchNode.requestFocus();
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              // decoration: const BoxDecoration(color: Colors.red),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Domains',
                        style: TextStyle(fontSize: 20),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            domainId = 0;
                          });
                        },
                        child: const Text('All'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _domains.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              domainId = _domains[index]['id'];
                            });
                          },
                          child: Text(_domains[index]['domain_name']),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Flexible(
            child: GridView.builder(
              controller: scrollController,
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
          ),
        ],
      ),
    );
  }
}
