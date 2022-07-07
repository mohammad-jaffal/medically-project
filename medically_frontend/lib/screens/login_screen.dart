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
  var _isLogin = true;

  var _loginEmail = '';
  var _loginPassword = '';

  var _signupName = '';
  var _signupEmail = '';
  var _signupPassword = '';
  var _signupConfirmPassword = '';

  void _loginFunction() {
    // _loginFormKey.currentState!.save();
    // // print(_loginEmail);
    // // print(_loginPassword);
  }

  void _signupFunction() {
    // _signupFormKey.currentState!.save();
    // // print(_signupName);
    // // print(_signupEmail);
    // // print(_signupPassword);
    // // print(_signupConfirmPassword);
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
                            color: Color.fromARGB(255, 0, 4, 255),
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 50),
                        TextFormField(
                          key: const ValueKey('login_email'),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)),
                            hintText: 'Email',
                          ),
                          onSaved: (value) {
                            _loginEmail = value.toString();
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          key: const ValueKey('login_password'),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)),
                            hintText: 'Password',
                          ),
                          obscureText: true,
                          onSaved: (value) {
                            _loginPassword = value.toString();
                          },
                        ),
                        const SizedBox(height: 50),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 0, 4, 255),
                            minimumSize: const Size.fromHeight(45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            textStyle: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          onPressed: _loginFunction,
                          child: const Text('Login'),
                        ),
                        const SizedBox(height: 30),
                        TextButton(
                          child: const Text(
                            'Signup',
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
                            color: Color.fromARGB(255, 0, 4, 255),
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 50),
                        TextFormField(
                          key: const ValueKey('signup_name'),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)),
                            hintText: 'name',
                          ),
                          onSaved: (value) {
                            _signupName = value.toString();
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          key: const ValueKey('signup_email'),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)),
                            hintText: 'Email',
                          ),
                          onSaved: (value) {
                            _signupEmail = value.toString();
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          key: const ValueKey('signup_password'),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)),
                            hintText: 'Password',
                          ),
                          obscureText: true,
                          onSaved: (value) {
                            _signupPassword = value.toString();
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          key: const ValueKey('signup_confirm_password'),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)),
                            hintText: 'Confirm password',
                          ),
                          obscureText: true,
                          onSaved: (value) {
                            _signupConfirmPassword = value.toString();
                          },
                        ),
                        const SizedBox(height: 50),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 0, 4, 255),
                            minimumSize: const Size.fromHeight(45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            textStyle: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          onPressed: _signupFunction,
                          child: const Text('SignUp'),
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
