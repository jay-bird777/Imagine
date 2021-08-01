import 'package:flutter/material.dart';

class ErrorPage extends StatefulWidget {
  ErrorPage({Key? key}) : super(key: key);
  String id = 'errorPage';


  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Text('error'),
        ),
      ),
    );
  }
}
