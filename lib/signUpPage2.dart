import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/loginPage.dart';
import 'package:my_app/signUpPage3.dart';

import 'homePage1.dart';

  class SignUpPage2 extends StatefulWidget {
    SignUpPage2({Key? key}) : super(key: key);
    String id = 'signUpPage2';

    @override
    _SignUpPage2State createState() => _SignUpPage2State();
  }

  class _SignUpPage2State extends State<SignUpPage2> {

    bool hideOrShow = true;

    void nav (){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => HomePage1(),
        ),
      );
    }

    void showText() {
      setState(() {
        hideOrShow = !hideOrShow;
      });
    }

    var _firstNameKey = GlobalKey<FormState>();
    var _lastNameKey = GlobalKey<FormState>();

    var _firstNameError;
    var _lastNameError;


    TextEditingController _firstNameController = TextEditingController();
    TextEditingController _lastNameController = TextEditingController();

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
                    radius: 70,
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
                      fontFamily: 'DancingScript',),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Container(
                    width: 350,
                    child: Form(
                      key: _firstNameKey,
                      child: TextFormField(
                        controller: _firstNameController,
                        maxLines: 1,
                        keyboardType: TextInputType.name,
                        scrollPadding: EdgeInsets.all(10),
                        decoration: InputDecoration(
                            errorText: _firstNameError,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'First Name'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  Container(
                    width: 350,
                    child: Form(
                      key: _lastNameKey,
                      child: TextFormField(
                        controller: _lastNameController,
                        maxLines: 1,
                        keyboardType: TextInputType.name,
                        scrollPadding: EdgeInsets.all(10),
                        decoration: InputDecoration(
                            errorText: _lastNameError,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Last Name'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32.0,
                  ),

                  SizedBox(
                    height: 180.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                        if (_lastNameController.text.length < 3)
                          setState(() {
                            _lastNameError = 'Enter at least 3 chars';
                          });
                        if(_firstNameController.text.length < 3)
                          _firstNameError = 'Enter at least 3 chars';

                        if(_lastNameController.text.length >= 3 && _firstNameController.text.length >= 3)
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => SignUpPage3(),
                            ),
                          );

                    },
                    child: Text('Submit'),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.blueGrey.shade700),
                  ),

                  TextButton(
                    style: ButtonStyle(
                    ),
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

