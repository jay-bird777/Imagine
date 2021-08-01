import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/homePage1.dart';
import 'package:my_app/services/auth.dart';
import 'package:my_app/signUpPage2.dart';
import 'package:my_app/userProfilePage.dart';


class LoginPage extends StatefulWidget {
  String id = 'loginPage';

  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  String email = '';
  String password = '';

  AuthService _auth = AuthService();

  void submitForm() {
    setState(() {
       dynamic  result = _auth.loginFirebaseUser(
          email, password);
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => UserProfilePage(),
      ),
    );
  }

  bool hideOrShow = true;

  void showText() {
    setState(() {
      hideOrShow = !hideOrShow;
    });
  }

  var _emailUsernameError;
  var _password2Error;



  TextEditingController _emailUsernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();



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
                  height: 50.0,
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
                  child: TextFormField(
                    onChanged: (val) {
                      setState(() => email = val.trim());
                    },
                    controller: _emailUsernameController,
                    maxLines: 1,
                    keyboardType: TextInputType.emailAddress,
                    scrollPadding: EdgeInsets.all(10),
                    decoration: InputDecoration(
                      errorText: _emailUsernameError,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Email/Username'),
                  ),
                ),
                SizedBox(
                  height: 32.0,
                ),
                Container(
                  width: 350,
                  child: TextFormField(
                    onChanged: (val) {
                      setState(() => password = val.trim());
                    },
                    controller: _passwordController,
                    maxLines: 1,
                    obscureText: hideOrShow,
                    scrollPadding: EdgeInsets.all(10),
                    decoration: InputDecoration(
                      errorText: _password2Error,
                        suffixIcon: IconButton(
                          icon: hideOrShow
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                          onPressed: () {
                            showText();
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Password'),
                  ),
                ),
                SizedBox(
                  height: 65.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_emailUsernameController.text.length < 3)
                        _emailUsernameError = 'Enter at least 3 chars';
                      else
                        _emailUsernameError = null;


                      if  (_passwordController.text.length < 6)
                        _password2Error = 'Enter at least 6 chars';
                      else if (_passwordController.text.length > 15)
                        _password2Error = 'Enter less than 15 chars';
                      else
                        _password2Error = null;

                    });

                    if (_emailUsernameController.text.length >= 3 && _passwordController.text.length >= 6 && _passwordController.text.length <= 15)
                      submitForm();
                  },
                  child: Text('Login'),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Text(
                  'Forgot Password?',
                  style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.blueGrey.shade700),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
