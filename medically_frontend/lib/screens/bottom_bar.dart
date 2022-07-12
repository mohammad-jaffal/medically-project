import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medically_frontend/providers/doctors_provider.dart';
import 'package:medically_frontend/screens/favorites_screen.dart';
import 'package:medically_frontend/screens/home_screen.dart';
import 'package:medically_frontend/screens/logs_screen.dart';
import 'package:medically_frontend/screens/user_info_screen.dart';
import 'package:provider/provider.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);
  static const routeName = '/bottom-bar-screen';
  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  var _pages;
  int _selectedIndex = 0;

  @override
  void initState() {
    _pages = [
      const HomeScreen(),
      const FavoritesScreen(),
      const LogsScreen(),
      const UserInfoScreen(),
    ];
    super.initState();
  }

  void _selectScreen(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // @override
  // void didChangeDependencies() {
  //   final doctorsProvider =
  //       Provider.of<DoctorsProvider>(context, listen: false);
  //   doctorsProvider.fetchDoctors();
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        child: BottomNavigationBar(
          unselectedItemColor: const Color.fromARGB(120, 255, 255, 255),
          onTap: _selectScreen,
          currentIndex: _selectedIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "Favorites",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.call),
              label: "Logs",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
