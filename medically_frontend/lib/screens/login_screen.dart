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
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'enter email';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            // _userEmail = value.toString();
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
                          validator: (value) {
                            if (value!.isEmpty || value.length < 6) {
                              return 'password < 6';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            // _userPassword = value.toString();
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
                          onPressed: () {},
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
                            // _userEmail = value.toString();
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
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'enter email';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            // _userEmail = value.toString();
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
                          validator: (value) {
                            if (value!.isEmpty || value.length < 6) {
                              return 'password < 6';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            // _userPassword = value.toString();
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
                          validator: (value) {
                            if (value!.isEmpty || value.length < 6) {
                              return 'password < 6';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            // _userPassword = value.toString();
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
                          onPressed: () {},
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
