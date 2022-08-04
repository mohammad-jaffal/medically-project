import 'package:flutter/material.dart';
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
  var chosenDomain = "All";
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

    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          // search box same as in favorites screen
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
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              searchNode.requestFocus();
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${chosenDomain}',
                      style: TextStyle(fontSize: 20),
                    ),
                    // show all domains button
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          domainId = 0;
                          chosenDomain = "All";
                        });
                      },
                      child: const Text('All'),
                    ),
                  ],
                ),
                // domains fileter buttons
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
                            chosenDomain = Provider.of<DoctorsProvider>(context,
                                    listen: false)
                                .getDomainName(domainId);
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
          // show doctors cards
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
