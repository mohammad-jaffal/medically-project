import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:medically_frontend/screens/favorites_screen.dart';
import 'package:medically_frontend/screens/home_screen.dart';
import 'package:medically_frontend/screens/logs_screen.dart';
import 'package:medically_frontend/screens/user_call_screen.dart';
import 'package:medically_frontend/screens/user_info_screen.dart';
import 'package:native_notify/native_notify.dart';

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
    // listen to notifications
    AwesomeNotifications()
        .displayedStream
        .listen((ReceivedNotification receivedNotification) {
      if (pushDataObject['accepted']) {
        // join call if call accepted
        Navigator.pop(context);
        Navigator.pushNamed(context, UserCallScreen.routeName);
      } else {
        // call declined
        print(pushDataObject['message']);
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('${pushDataObject['message']}'),
              actions: [
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }
      AwesomeNotifications().cancelAll();
    });
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
