import 'package:flutter/material.dart';
import 'package:medically_frontend/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool _isDark = false;

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: _isDark ? Colors.grey : Colors.white,
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}
