import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medically_frontend/doctor_screens/doctor_bottom_bar.dart';
import 'package:medically_frontend/models/doctor.dart';
import 'package:medically_frontend/providers/doctor_provider.dart';
import 'package:medically_frontend/providers/token_provider.dart';
import 'package:medically_frontend/providers/user_provider.dart';
import 'package:medically_frontend/screens/bottom_bar.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../consts/constants.dart';
import '../models/user.dart';
import '../providers/doctors_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/login-screen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool fetching = false;
  TokenProvider tokenProvider = TokenProvider();
  String apiConst = Constants.api_const;

  final _loginFormKey = GlobalKey<FormState>();
  final _signupFormKey = GlobalKey<FormState>();
  var _isLogin = true;

  Future<String> getCurrentToken() async {
    // get token saved in device storage
    var token = (await tokenProvider.tokenPrefs.getToken()).toString();
    return token;
  }

  void createAlert(BuildContext context, var message) {
    showDialog(
      // show alert if not enough balance
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$message'),
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

  @override
  void initState() {
    setState(() {
      fetching = true;
    });
    final tokenProvider = Provider.of<TokenProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // check if user logged out
      var saved_token = (await getCurrentToken());
      if (saved_token == 'none') {
        setState(() {
          fetching = false;
        });
      } else {
        // check if the token is still active
        tokenProvider.setToken(saved_token);
        var validateReturn =
            await tokenProvider.validateToken(saved_token, context);
        if (validateReturn == 'none') {
          // the token expired
          // print('token expired');
          setState(() {
            fetching = false;
          });
          // navigate to screen if user or doctor
        } else if (validateReturn == 'user') {
          Navigator.of(context).pushReplacementNamed(BottomBarScreen.routeName);
        } else if (validateReturn == 'doctor') {
          Navigator.of(context)
              .pushReplacementNamed(DoctorBottomBarScreen.routeName);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tokenProvider = Provider.of<TokenProvider>(context, listen: false);

    var user_type;
    // input fields text
    var _loginEmail = '';
    var _loginPassword = '';

    var _signupName = '';
    var _signupEmail = '';
    var _signupPassword = '';
    var _signupConfirmPassword = '';

    Future<void> _loginFunction() async {
      // logging in :)
      var url = Uri.parse('$apiConst/login');
      var response = await http.post(url, body: {
        'email': _loginEmail,
        'password': _loginPassword,
      });
      if (response.statusCode == 200) {
        setState(() {
          // to show circular progress indicator
          fetching = true;
        });
        // validate token (get logged in profile info)
        var access_token = json.decode(response.body)['access_token'];
        tokenProvider.setToken(access_token);
        var validateReturn =
            await tokenProvider.validateToken(access_token, context);
        if (validateReturn == 'none') {
          // this should not happen :)
          setState(() {
            fetching = false;
          });
        } else if (validateReturn == 'user') {
          Navigator.of(context).pushReplacementNamed(BottomBarScreen.routeName);
        } else if (validateReturn == 'doctor') {
          Navigator.of(context)
              .pushReplacementNamed(DoctorBottomBarScreen.routeName);
        }
      } else {
        // if user entered wrong data
        createAlert(context, 'Wrong credentials!');
      }
    }

    Future<void> _signupFunction(var type) async {
      _signupFormKey.currentState!.save();

      if (_signupName == '' ||
          _signupEmail == '' ||
          _signupPassword == '' ||
          _signupConfirmPassword == '') {
        // print('fill all');
        createAlert(context, 'Fill all fields!');
      } else {
        if (_signupPassword != _signupConfirmPassword) {
          createAlert(context, 'Passwords do not match!');

          // print('unmatching passwords');
        } else {
          var url = Uri.parse('$apiConst/register');
          var response = await http.post(url, body: {
            'name': _signupName,
            'email': _signupEmail,
            'password': _signupPassword,
            'password_confirmation': _signupConfirmPassword,
            'type': type.toString(),
          });
          // automatically log in the registered user
          if (json.decode(response.body)['message'] ==
              'User successfully registered') {
            _loginEmail = _signupEmail;
            _loginPassword = _signupPassword;
            _loginFunction();
          }
        }
      }
    }

    if (fetching) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          0,
          MediaQuery.of(context).viewPadding.top,
          0,
          0,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: _isLogin
                  // log in form ---------------------------
                  ? Form(
                      key: _loginFormKey,
                      child: Column(
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
                            textAlign: TextAlign.center,
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
                            textAlign: TextAlign.center,
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
                            onPressed: () {
                              _loginFormKey.currentState!.save();
                              _loginFunction();
                            },
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
                            textAlign: TextAlign.center,
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
                            textAlign: TextAlign.center,
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
                            textAlign: TextAlign.center,
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
                            textAlign: TextAlign.center,
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
                            onPressed: () {
                              _signupFunction(1);
                            },
                            child: const Text('Sign Up'),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              minimumSize: const Size.fromHeight(45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              _signupFunction(3);
                            },
                            child: const Text(
                              'Sign Up as Doctor',
                              style: TextStyle(
                                color: Color.fromARGB(255, 54, 135, 255),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
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
      ),
    );
  }
}
