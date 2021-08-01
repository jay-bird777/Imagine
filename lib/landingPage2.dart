import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/signUpPage.dart';

import 'loginPage.dart';

class LandingPage2 extends StatefulWidget {
  LandingPage2({Key? key}) : super(key: key);
  String id = 'landingPage2';

  @override
  _LandingPage2State createState() => _LandingPage2State();
}

bool _isButtonDisabled = true;
double opacity = 0.0;
double opacity2 = 0.0;

class _LandingPage2State extends State<LandingPage2> {

  void popup(){
    if(opacity == 0.0)
      setState(() {
        _isButtonDisabled = false;
      });
  }

  changeOpacity() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        opacity = 1.0;
      });
    });
  }
  changeOpacity2() {

    Future.delayed(Duration(seconds: 8), () {
      setState(() {
        opacity2 = 1.0;
      });
    });

  }

  @override
  Widget build(BuildContext context) {

    changeOpacity();
    if(opacity == opacity2)
      setState(() {
        opacity = 0.0;
      });
      changeOpacity2();



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
                    "images/forest.jpeg",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.black12.withOpacity(0.2),
                    Colors.purple.shade500.withOpacity(0.2),
                  ]),
                ),
              ),
            ),

            SafeArea(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment(
                      0,
                      -0.7,
                    ),
                    child: Text(
                      'Imagine',
                      style: TextStyle(
                        fontSize: 80,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'DancingScript',
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                        width: double.maxFinite,
                        alignment: Alignment.center,
                        child: AnimatedOpacity(
                          opacity: opacity,
                          duration: Duration(seconds: 2),
                          child: Text(
                            'The worlds greatest platform for you share your talent for digital art '
                                'and to connect with artist across the globe',
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'DancingScript',
                            ),
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                        width: double.maxFinite,
                        alignment: Alignment.center,
                        child: AnimatedOpacity(
                          opacity: opacity2,
                          duration: Duration(seconds: 2),
                          child: Text(
                            'Tap below to sign up or login',
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'DancingScript',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    child: AnimatedOpacity(
                      opacity: opacity2,
                      duration: Duration(seconds: 3),
                      child: OutlinedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.black12),

                        ),
                        onPressed: (){
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                              builder: (BuildContext context) => SignUpPage(),
                          )
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),




                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    child: AnimatedOpacity(
                      opacity: opacity2,
                      duration: Duration(seconds: 3),
                      child: OutlinedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.black12),

                        ),
                        onPressed: (){
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => LoginPage(),
                              )
                          );
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),




                      ),
                    ),
                  ),
                ],
              ),
            ),
            //this stack contains the two texts displayed on screen
            if(opacity == 1.0)
              TextButton(
              onPressed: () {
                opacity = 0.0;
                opacity2 = 1.0;
              },
              child: SizedBox(
                width: double.maxFinite,
                height: double.maxFinite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
