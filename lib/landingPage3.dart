import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class LandingPage3 extends StatefulWidget {
  const LandingPage3({Key? key}) : super(key: key);

  @override
  _LandingPage3State createState() => _LandingPage3State();
}

class _LandingPage3State extends State<LandingPage3> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
      ),
    );
  }
}
