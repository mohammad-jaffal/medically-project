import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medically_frontend/providers/calls_provider.dart';
import 'package:medically_frontend/providers/doctors_provider.dart';
import 'package:medically_frontend/providers/user_provider.dart';
import 'package:medically_frontend/screens/favorites_screen.dart';
import 'package:medically_frontend/screens/home_screen.dart';
import 'package:medically_frontend/screens/logs_screen.dart';
import 'package:medically_frontend/screens/user_call_screen.dart';
import 'package:medically_frontend/screens/user_info_screen.dart';
import 'package:native_notify/native_notify.dart';
import 'package:provider/provider.dart';

import '../providers/reviews_provider.dart';

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
    AwesomeNotifications()
        .displayedStream
        .listen((ReceivedNotification receivedNotification) {
      if (pushDataObject['accepted']) {
        Navigator.pop(context);
        Navigator.pushNamed(context, UserCallScreen.routeName);
      } else {
        print(pushDataObject['message']);
        Navigator.pop(context);
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
