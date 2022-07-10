import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../providers/dark_theme_provider.dart';
import '../providers/doctors_provider.dart';
import '../widgets/doctor_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final searchNode = FocusNode();
  var searchText = '';
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
    var _doctors = doctorsProvider.getFavorites(searchText);
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
              hintText: 'Search',
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
