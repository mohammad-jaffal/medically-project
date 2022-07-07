import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medically_frontend/screens/favorites_screen.dart';
import 'package:medically_frontend/screens/home_screen.dart';
import 'package:medically_frontend/screens/logs_screen.dart';
import 'package:medically_frontend/screens/user_info_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(width: 0.5),
            ),
          ),
          child: BottomNavigationBar(
            onTap: _selectScreen,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            currentIndex: _selectedIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: "MyList",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.call),
                label: "Logs",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Me",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
