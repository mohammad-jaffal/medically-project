import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medically_frontend/doctor_screens/doctor_call_screen.dart';
import 'package:medically_frontend/doctor_screens/doctor_info_screen.dart';
import 'package:medically_frontend/doctor_screens/doctor_logs_screen.dart';
import 'package:medically_frontend/doctor_screens/doctor_reviews_screen.dart';
import 'package:medically_frontend/providers/doctor_provider.dart';
import 'package:native_notify/native_notify.dart';
import 'package:provider/provider.dart';

import '../providers/agora_provider.dart';
import '../providers/calls_provider.dart';
import '../providers/reviews_provider.dart';
import 'doctor_ringing_screen.dart';

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
    // listen to notifications
    AwesomeNotifications()
        .displayedStream
        .listen((ReceivedNotification receivedNotification) {
      final agoraProvider = Provider.of<AgoraProvider>(context, listen: false);

      var inCall = agoraProvider.getInCall;
      // save caller data in agora provider
      agoraProvider.setCallerID(pushDataObject['userID']);
      agoraProvider.setCallerName(pushDataObject['userName']);
      agoraProvider.setCallerImage(pushDataObject['userImage']);
      // notify the caller back if the doctor is already in a call
      if (inCall) {
        print('already in call');
        NativeNotify.sendIndieNotification(
            1117,
            '0XErqq1jB7rDHxJbpRwhjt',
            '${pushDataObject['userID']}',
            'Call action',
            'already in call',
            null,
            '{"accepted":false, "message":"already in call"}');
        AwesomeNotifications().cancelAll();
      } else {
        // redirect doctor to ringing screen
        AwesomeNotifications().cancelAll();
        agoraProvider.setInCall(true);
        Navigator.pushNamed(context, DoctorRingingScreen.routeName);
      }
    });
    _pages = [
      const DoctorReviewsScreen(),
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
    final doctorProvider = Provider.of<DoctorProvider>(context);
    // save doctor channel info in agora provider
    Provider.of<AgoraProvider>(context, listen: false).setData(
      doctorProvider.getDoctor.channelToken,
      doctorProvider.getDoctor.channelName,
    );
    var did = doctorProvider.getDoctorId;
    // fetch doctor's reviews
    final reviewsProvider =
        Provider.of<ReviewsProvider>(context, listen: false);
    reviewsProvider.fetchReviews(did);

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        child: BottomNavigationBar(
          unselectedItemColor: const Color.fromARGB(120, 255, 255, 255),
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
