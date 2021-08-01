
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/homePage1.dart';

class SignUpPage3 extends StatefulWidget {
  SignUpPage3({Key? key}) : super(key: key);

  String id = 'signUpPage3';

  @override
  _SignUpPage3State createState() => _SignUpPage3State();
}

double buttonOpacity = 0.0;
bool imageChanged = false;

double opacity = 0.0;
bool stopLoop = false;


class _SignUpPage3State extends State<SignUpPage3> {

  void loop() {
    setState(() {
      stopLoop = true;
    });
  }

  changeOpacity() {
    Future.delayed(Duration(seconds: 2), () {
      if (stopLoop == false)
        setState(() {
          opacity = opacity == 0.0 ? 1.0 : 0.0;
        });
      else if (stopLoop == true)
        setState(() {
          opacity = 0;
        });
    });
  }


var _profileImage;
final picker = ImagePicker();

Future getImageCamera() async{
  final pickedImage =  await picker.pickImage(source: ImageSource.camera);

  setState(() {
    if(pickedImage != null){
      _profileImage = File(pickedImage.path);
      imageChanged = !imageChanged;
    }else{
      print('No Image Selected');
    }
  });
}

Future getImageGallery() async{
  final pickedImage =  await picker.pickImage(source: ImageSource.gallery);

  setState(() {
    if(pickedImage != null){
      _profileImage = File(pickedImage.path);
      imageChanged = !imageChanged;
    }else{
      print('No Image Selected');
    }
  });
}

 
  @override
  Widget build(BuildContext context) {
    changeOpacity();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children:[
              SizedBox(
                height: 20,
              ),
              Text(
                    'Imagine',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'DancingScript',),
                  ),
              SizedBox(
                height: 100,
              ),
              // this line will check to see if the user is on ios or andriod and respond accordingly
              if(Platform.isIOS)
                Container(
                  child: CupertinoButton(
                    onPressed: () {
                      showCupertinoModalPopup<void>(
                        context: context,
                        builder: (BuildContext context) => CupertinoActionSheet(
                          title: const Text('Avatar'),
                          message: const Text('Select Avatar'),
                          actions: <CupertinoActionSheetAction>[
                            CupertinoActionSheetAction(
                              child: const Text(
                                'Camera',
                                style: TextStyle(

                                ),
                              ),
                              onPressed: () {
                                getImageCamera();
                                Navigator.pop(context);
                              },
                            ),
                            CupertinoActionSheetAction(
                              child: const Text('Gallery'),
                              onPressed: () {
                                getImageGallery();
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ),
                      );
                    },
                    child: _profileImage != null
                        ? CircleAvatar(
                      radius: 75,
                      backgroundColor: Colors.lightBlueAccent,
                      child: CircleAvatar(
                        radius: 70,
                        backgroundImage: FileImage(_profileImage),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 20.0,
                          ),
                        ),
                      ),
                    )
                        : CircleAvatar(
                      radius: 75,
                      backgroundColor: Colors.lightBlueAccent,
                      child: CircleAvatar(
                        radius: 70,
                        child: Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            child: Icon(
                              Icons.person_rounded,
                              size: 20,
                            ),
                            radius: 50,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              if(Platform.isAndroid)
                Container(
                  child: CupertinoButton(
                    onPressed: () {
                      showCupertinoModalPopup<void>(
                        context: context,
                        builder: (BuildContext context) => CupertinoActionSheet(
                          title: const Text('Avatar'),
                          message: const Text('Select Avatar'),
                          actions: <CupertinoActionSheetAction>[
                            CupertinoActionSheetAction(
                              child: const Text(
                                'Camera',
                                style: TextStyle(

                                ),
                              ),
                              onPressed: () {
                                getImageCamera();
                                Navigator.pop(context);
                              },
                            ),
                            CupertinoActionSheetAction(
                              child: const Text('Gallery'),
                              onPressed: () {
                                getImageGallery();
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ),
                      );
                    },
                    child: _profileImage != null
                        ? CircleAvatar(
                      radius: 75,
                      backgroundColor: Colors.lightBlueAccent,
                      child: CircleAvatar(
                        radius: 70,
                        backgroundImage: FileImage(_profileImage),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 20.0,
                          ),
                        ),
                      ),
                    )
                        : CircleAvatar(
                      radius: 75,
                      backgroundColor: Colors.lightBlueAccent,
                      child: CircleAvatar(
                        radius: 70,
                        child: Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            child: Icon(
                              Icons.person_rounded,
                              size: 20,
                            ),
                            radius: 50,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

              Container(
                margin: EdgeInsets.all(40),
                child: Text(
                  'Avatar',
                  style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.all(30),
                child: imageChanged
                    ? Container(
                  margin: EdgeInsets.all(82),
                      width: 100,
                      height: 40,
                      child: ElevatedButton(
                  onPressed: (){
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => HomePage1(),
                          )
                      );
                  },
                  child: Text('Submit'),),
                    )
                    : AnimatedOpacity(
                  opacity: opacity,
                  duration: Duration(seconds: 2),
                  child: Text(
                    'Tap the avatar to select an image',
                    style: TextStyle(
                      fontSize: 21.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
                  
            ],
          ),
        ),
      ),
    );
  }
}
