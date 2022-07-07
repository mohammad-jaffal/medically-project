import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final _signupFormKey = GlobalKey<FormState>();
  final _isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: _isLogin
              ? Form(
                  key: _loginFormKey,
                  child: Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 4, 255),
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              : Form(
                  key: _signupFormKey,
                  child: Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        'SignUp',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 4, 255),
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
