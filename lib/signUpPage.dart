import 'dart:core';

import 'package:flutter/material.dart';
import 'package:my_app/loginPage.dart';
import 'package:my_app/services/auth.dart';
import 'package:my_app/signUpPage2.dart';

import 'homePage1.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);
  String id = 'signUpPage';

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  void submitForm() {
    setState(() {
      dynamic result = _auth.registerFirebaseUser(
          email, password);
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => SignUpPage2(),
      ),
    );
  }
  bool hideOrShow = true;

  void showText() {
    setState(() {
      hideOrShow = !hideOrShow;
    });
  }

  var _emailKey = GlobalKey<FormState>();
  var _usernameKey = GlobalKey<FormState>();
  var _passwordKey = GlobalKey<FormState>();

  var _emailError;
  var _passwordError;
  var _usernameError;

  bool _emailCheck = false;

  TextEditingController _passwordController2 = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();

  String email = '';
  String password = '';

  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.blueGrey,
                  backgroundImage: AssetImage('images/1600w-SNVtBzp-x7g.webp'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Imagine',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'DancingScript',
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Container(
                  width: 350,
                  child: Form(
                    key: _emailKey,
                    child: TextFormField(
                      onChanged: (val) {
                        setState(() => email = val.trim());
                      },
                      validator: (value) {
                        if (value!.contains('@')) {
                          _emailError = null;
                          _emailCheck = true;
                          return null;
                        } else {
                          _emailError = 'Enter a valid email address';
                        }
                      },
                      controller: _emailController,
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
                      scrollPadding: EdgeInsets.all(10),
                      decoration: InputDecoration(
                          errorText: _emailError,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: '@Example.com'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 32.0,
                ),
                Container(
                  width: 350,
                  child: Form(
                    key: _usernameKey,
                    child: TextFormField(
                      controller: _usernameController,
                      maxLines: 1,
                      scrollPadding: EdgeInsets.all(10),
                      decoration: InputDecoration(
                          errorText: _usernameError,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Username'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 32.0,
                ),
                Container(
                  width: 350,
                  child: Form(
                    key: _passwordKey,
                    child: TextFormField(
                      onChanged: (val) {
                        setState(() => password = val.trim());
                      },
                      controller: _passwordController2,
                      maxLines: 1,
                      obscureText: hideOrShow,
                      scrollPadding: EdgeInsets.all(10),
                      decoration: InputDecoration(
                          errorText: _passwordError,

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Password'),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 100, 0, 30),
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        if (_emailKey.currentState!.validate() &&
                            _emailCheck == true) _emailError = null;

                        if (_usernameController.text.length < 3)
                          _usernameError = 'Enter at least 3 chars';
                        else if (_usernameController.text.length > 20)
                          _usernameError = 'Enter less than 20 chars';
                        else
                          _usernameError = null;

                        if (_passwordController2.text.length < 6)
                          _passwordError = 'Enter at least 6 chars';
                        else if (_passwordController2.text.length > 15)
                          _passwordError = 'Enter less than 15 chars';
                        else
                          _passwordError = null;
                      });

                      if (_usernameController.text.length >= 3 &&
                          _usernameController.text.length <= 20 &&
                          _passwordController2.text.length >= 6 &&
                          _passwordController2.text.length <= 15 &&
                          _emailCheck == true) {
                        submitForm();
                      }
                    },
                    child: Text('Submit'),
                  ),
                ),
                Text(
                  'Already have an account?',
                  style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.blueGrey.shade700),
                ),
                TextButton(
                  style: ButtonStyle(),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.blueGrey.shade700),
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
