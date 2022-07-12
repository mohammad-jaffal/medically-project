import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medically_frontend/doctor_screens/doctor_bottom_bar.dart';
import 'package:medically_frontend/screens/bottom_bar.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/login-screen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final user_type = 1;
  final _loginFormKey = GlobalKey<FormState>();
  final _signupFormKey = GlobalKey<FormState>();
  var _isLogin = true;

  var _loginEmail = '';
  var _loginPassword = '';

  var _signupName = '';
  var _signupEmail = '';
  var _signupPassword = '';
  var _signupConfirmPassword = '';

  Future<void> _loginFunction() async {
    print('fetching');
    var url = Uri.parse('http://10.0.2.2:8000/api/login');
    var response = await http.post(url, body: {
      'email': 'test1@gmail.com',
      'password': '121212',
    });
    print('Response body: ${response.body}');
// http://10.0.2.2:8000/api/user/allitems'
    // print(await http.read(Uri.parse('https://example.com/foobar.txt')));

    // _loginFormKey.currentState!.save();
    // // print(_loginEmail);
    // // print(_loginPassword);
    // if user go user screens
    // if (user_type == 1) {
    //   Navigator.of(context).pushReplacementNamed(
    //     BottomBarScreen.routeName,
    //     arguments: {},
    //   );
    //   // if doctor go to doctor screens
    // } else if (user_type == 2) {
    //   Navigator.of(context).pushReplacementNamed(
    //     DoctorBottomBarScreen.routeName,
    //     arguments: {},
    //   );
    // } else {
    //   print('do nothing');
    // }
  }

  void _signupFunction() {
    // _signupFormKey.currentState!.save();
    // // print(_signupName);
    // // print(_signupEmail);
    // // print(_signupPassword);
    // // print(_signupConfirmPassword);

    // if user go user screens
    if (user_type == 1) {
      Navigator.of(context).pushReplacementNamed(
        BottomBarScreen.routeName,
        arguments: {},
      );
    }

    // if doctor go to doctor screens
    if (user_type == 2) {
      Navigator.of(context).pushReplacementNamed(
        DoctorBottomBarScreen.routeName,
        arguments: {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: _isLogin
                // log in form ---------------------------
                ? Form(
                    key: _loginFormKey,
                    child: Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Text(
                          'Login',
                          style: TextStyle(
                            color: Color.fromARGB(255, 54, 135, 255),
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 50),
                        TextFormField(
                          style: const TextStyle(
                            color: Color.fromARGB(255, 54, 135, 255),
                          ),
                          key: const ValueKey('login_email'),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)),
                            hintText: 'Email',
                            hintStyle: const TextStyle(
                              color: Colors.blueGrey,
                            ),
                          ),
                          onSaved: (value) {
                            _loginEmail = value.toString();
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          style: const TextStyle(
                            color: Color.fromARGB(255, 54, 135, 255),
                          ),
                          key: const ValueKey('login_password'),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)),
                            hintText: 'Password',
                            hintStyle: const TextStyle(
                              color: Colors.blueGrey,
                            ),
                          ),
                          obscureText: true,
                          onSaved: (value) {
                            _loginPassword = value.toString();
                          },
                        ),
                        const SizedBox(height: 50),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 54, 135, 255),
                            minimumSize: const Size.fromHeight(45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: _loginFunction,
                          child: const Text('Login'),
                        ),
                        const SizedBox(height: 30),
                        TextButton(
                          child: const Text(
                            'Sign up',
                            style: TextStyle(fontSize: 18),
                          ),
                          onPressed: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                        ),
                      ],
                    ),
                  )
                // sign up form ------------------------
                : Form(
                    key: _signupFormKey,
                    child: Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Text(
                          'Sign up',
                          style: TextStyle(
                            color: Color.fromARGB(255, 54, 135, 255),
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 50),
                        TextFormField(
                          style: const TextStyle(
                            color: Color.fromARGB(255, 54, 135, 255),
                          ),
                          key: const ValueKey('signup_name'),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)),
                            hintText: 'name',
                            hintStyle: const TextStyle(
                              color: Colors.blueGrey,
                            ),
                          ),
                          onSaved: (value) {
                            _signupName = value.toString();
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          style: const TextStyle(
                            color: Color.fromARGB(255, 54, 135, 255),
                          ),
                          key: const ValueKey('signup_email'),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)),
                            hintText: 'Email',
                            hintStyle: const TextStyle(
                              color: Colors.blueGrey,
                            ),
                          ),
                          onSaved: (value) {
                            _signupEmail = value.toString();
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          style: const TextStyle(
                            color: Color.fromARGB(255, 54, 135, 255),
                          ),
                          key: const ValueKey('signup_password'),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)),
                            hintText: 'Password',
                            hintStyle: const TextStyle(
                              color: Colors.blueGrey,
                            ),
                          ),
                          obscureText: true,
                          onSaved: (value) {
                            _signupPassword = value.toString();
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          style: const TextStyle(
                            color: Color.fromARGB(255, 54, 135, 255),
                          ),
                          key: const ValueKey('signup_confirm_password'),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)),
                            hintText: 'Confirm password',
                            hintStyle: const TextStyle(
                              color: Colors.blueGrey,
                            ),
                          ),
                          obscureText: true,
                          onSaved: (value) {
                            _signupConfirmPassword = value.toString();
                          },
                        ),
                        const SizedBox(height: 50),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 54, 135, 255),
                            minimumSize: const Size.fromHeight(45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: _signupFunction,
                          child: const Text('Sign Up'),
                        ),
                        const SizedBox(height: 30),
                        TextButton(
                          child: const Text(
                            'Login',
                            style: TextStyle(fontSize: 18),
                          ),
                          onPressed: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
