import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    var _doctors = doctorsProvider.getFavorites(searchText);

    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          // app bar search box
          title: TextField(
            focusNode: searchNode,
            onChanged: (value) {
              // update the list by doctors containing inserted chatacters
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
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              // show keyboard
              searchNode.requestFocus();
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        children: [
          Flexible(
            child: _doctors.isEmpty
                ? const Center(child: Text('No Doctors Found!'))
                : GridView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.all(10),
                    itemCount: _doctors.length,
                    itemBuilder: (ctx, i) => DoctorCard(_doctors[i]),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 4 / 1,
                      mainAxisSpacing: 15,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
