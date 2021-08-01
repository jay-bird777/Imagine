import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_app/errorPage.dart';
import 'package:my_app/landingPage2.dart';
import 'package:my_app/services/auth.dart';
import 'package:my_app/signUpPage2.dart';
import 'package:my_app/signUpPage3.dart';
import 'package:my_app/userProfilePage.dart';

import 'homePage1.dart';
import 'homePage2.dart';
import 'landingPage.dart';
import 'landingPage3.dart';
import 'loginPage.dart';
import 'signUpPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _initialized = false;
  bool _error = false;

  //connecting to Firebase
  void _initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    _initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return Container(
        child: Text('Error'),
      );
    }
    if (!_initialized) {
      return Scaffold(
        body: Stack(
          alignment: new Alignment(
            0,
            0.0,
          ),
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "images/0f213150179683.58c970f0c8548.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.orangeAccent.withOpacity(0.5),
                    Colors.black12.withOpacity(0.2),
                  ]),
                ),
              ),
            ),

            //this stack contains the two texts displayed on screen
            Container(
              child: Stack(
                alignment: new Alignment(
                  0,
                  6.0,
                ),
                children: [
                  // this button is responsible for the fading in of second text
                  Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 70,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'DancingScript',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Streamer();
  }
}

class Streamer extends StatefulWidget {
  const Streamer({Key? key}) : super(key: key);

  @override
  _StreamerState createState() => _StreamerState();
}

class _StreamerState extends State<Streamer> {
  final _streamProvider = AuthService().user;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder(
            stream: _streamProvider,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return snapshot.connectionState == ConnectionState.waiting
                    ? LandingPage()
                    : HomePage1();
              } else {
                return LoginPage();
              }
            }),

    );
  }
}
