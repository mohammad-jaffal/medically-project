import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medically_frontend/doctor_screens/doctor_info_screen.dart';
import 'package:medically_frontend/doctor_screens/doctor_logs_screen.dart';
import 'package:medically_frontend/doctor_screens/doctor_reviews_screen.dart';

class DoctorBottomBarScreen extends StatefulWidget {
  const DoctorBottomBarScreen({Key? key}) : super(key: key);
  static const routeName = '/doctor-bottom-bar-screen';
  @override
  State<DoctorBottomBarScreen> createState() => _DoctorBottomBarScreenState();
}

class _DoctorBottomBarScreenState extends State<DoctorBottomBarScreen> {
  var _pages;
  int _selectedIndex = 0;

  @override
  void initState() {
    _pages = [
      const DoctorReviewsScreen(),
      // const FavoritesScreen(),
      const DoctorLogsScreen(),
      const DoctorInfoScreen(),
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
          type: BottomNavigationBarType.shifting,
          onTap: _selectScreen,
          currentIndex: _selectedIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.rate_review),
              label: "Reviews",
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
