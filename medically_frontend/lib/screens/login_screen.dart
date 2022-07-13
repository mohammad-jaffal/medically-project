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
  Future<String> getCurrentToken() async {
    var token = (await tokenProvider.tokenPrefs.getToken()).toString();
    // print(token);
    return token;
  }

  @override
  void initState() {
    final tokenProvider = Provider.of<TokenProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final doctorProvider = Provider.of<DoctorProvider>(context, listen: false);
    final doctorsProvider =
        Provider.of<DoctorsProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var saved_token = (await getCurrentToken());
      if (saved_token == 'none') {
      } else {
        setState(() {
          fetching = true;
        });
        tokenProvider.setToken(saved_token);
        var saved_body =
            json.decode(await tokenProvider.validateToken(saved_token));

        var saved_type = saved_body['type'];
        if (saved_type == 1) {
          var u = User(
            id: saved_body['id'],
            name: saved_body['name'],
            email: saved_body['email'],
            base64Image: saved_body['profile_picture'],
            balance: saved_body['balance'],
            type: saved_body['type'],
          );

          await doctorsProvider.fetchDoctors();
          userProvider.setuser(u);
          Navigator.of(context).pushReplacementNamed(BottomBarScreen.routeName);

          // if doctor go to doctor screens
        } else if (saved_type == 2) {
          var detailsUrl = Uri.parse('http://10.0.2.2:8000/api/get-doctor');
          var detailsResponse = await http.post(detailsUrl, body: {
            'doctor_id': '${saved_body['id']}',
          });
          if (detailsResponse.statusCode == 200) {
            var details_response_body =
                json.decode(detailsResponse.body)['doctor'][0];

            var d = Doctor(
              id: details_response_body['id'],
              name: details_response_body['name'],
              email: details_response_body['email'],
              base64Image: details_response_body['profile_picture'],
              balance: details_response_body['balance'],
              type: details_response_body['type'],
              rating: double.parse(details_response_body['rating']),
              channelName: details_response_body['channel_name'],
              channelToken: details_response_body['channel_token'],
              bio: details_response_body['bio'],
              domainId: details_response_body['domain_id'],
              online: details_response_body['online'] == 1,
            );
            doctorProvider.setDoctor(d);

            Navigator.of(context)
                .pushReplacementNamed(DoctorBottomBarScreen.routeName);
          }
        } else {
          print('do nothing');
        }
      }
    });
    // tokenProvider.setToken(getCurrentToken());
    // print(tokenProvider.validateToken());
    super.initState();
  }

  final _loginFormKey = GlobalKey<FormState>();
  final _signupFormKey = GlobalKey<FormState>();
  var _isLogin = true;
  @override
  Widget build(BuildContext context) {
    final tokenProvider = Provider.of<TokenProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final doctorProvider = Provider.of<DoctorProvider>(context, listen: false);
    final doctorsProvider =
        Provider.of<DoctorsProvider>(context, listen: false);

    var user_type;

    var _loginEmail = '';
    var _loginPassword = '';

    var _signupName = '';
    var _signupEmail = '';
    var _signupPassword = '';
    var _signupConfirmPassword = '';

    Future<void> _loginFunction() async {
      // print('fetching');
      var url = Uri.parse('http://10.0.2.2:8000/api/login');
      var response = await http.post(url, body: {
        'email': _loginEmail,
        'password': _loginPassword,
      });
      if (response.statusCode == 200) {
        setState(() {
          fetching = true;
        });
        var access_token = json.decode(response.body)['access_token'];
        tokenProvider.setToken(access_token);
        var response_body =
            json.decode(await tokenProvider.validateToken(access_token));
        user_type = response_body['type'];
        if (user_type == 1) {
          var u = User(
            id: response_body['id'],
            name: response_body['name'],
            email: response_body['email'],
            base64Image: response_body['profile_picture'],
            balance: response_body['balance'],
            type: response_body['type'],
          );

          await doctorsProvider.fetchDoctors();
          userProvider.setuser(u);
          Navigator.of(context).pushReplacementNamed(BottomBarScreen.routeName);

          // if doctor go to doctor screens
        } else if (user_type == 2) {
          var detailsUrl = Uri.parse('http://10.0.2.2:8000/api/get-doctor');
          var detailsResponse = await http.post(detailsUrl, body: {
            'doctor_id': '${response_body['id']}',
          });
          if (detailsResponse.statusCode == 200) {
            var details_response_body =
                json.decode(detailsResponse.body)['doctor'][0];

            var d = Doctor(
              id: details_response_body['id'],
              name: details_response_body['name'],
              email: details_response_body['email'],
              base64Image: details_response_body['profile_picture'],
              balance: details_response_body['balance'],
              type: details_response_body['type'],
              rating: double.parse(details_response_body['rating']),
              channelName: details_response_body['channel_name'],
              channelToken: details_response_body['channel_token'],
              bio: details_response_body['bio'],
              domainId: details_response_body['domain_id'],
              online: details_response_body['online'] == 1,
            );
            doctorProvider.setDoctor(d);

            Navigator.of(context)
                .pushReplacementNamed(DoctorBottomBarScreen.routeName);
          }
        } else {
          print('do nothing');
        }
        // Navigator.of(context)
        //     .pushReplacementNamed(BottomBarScreen.routeName, arguments: {});
      } else {
        print('wrong data');
      }

      // if user go user screens
    }

    Future<void> _signupFunction() async {
      _signupFormKey.currentState!.save();

      if (_signupName == '' ||
          _signupEmail == '' ||
          _signupPassword == '' ||
          _signupConfirmPassword == '') {
        print('fill all');
      } else {
        if (_signupPassword != _signupConfirmPassword) {
          print('unmatching passwords');
        } else {
          var url = Uri.parse('http://10.0.2.2:8000/api/register');
          var response = await http.post(url, body: {
            'name': _signupName,
            'email': _signupEmail,
            'password': _signupPassword,
            'password_confirmation': _signupConfirmPassword,
          });
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
