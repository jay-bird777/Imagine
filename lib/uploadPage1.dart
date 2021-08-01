import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/homePage1.dart';
import 'package:my_app/userProfilePage.dart';
import 'package:my_app/services/data_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';


class UploadPage1 extends StatefulWidget {
  UploadPage1({Key? key}) : super(key: key);
  String id = 'uploadPage';

  @override
  _UploadPage1State createState() => _UploadPage1State();
}

class _UploadPage1State extends State<UploadPage1> {

  var _image;
  final picker = ImagePicker();



  final DataService _data = DataService();

  var url = '';
  String desc = '';
  String category = '';

  Future getImageGallery() async{
    final pickedImage =  await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if(pickedImage != null){
        _image = File(pickedImage.path);
      }else{
        print('No Image Selected');
      }
    });
  }


   uploadImage() async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();

    //Check Permissions


    if (_image != null){
      //Select Image
      var file = File(_image.path);

      if (_image != null){
        //Upload to Firebase
        var snapshot = await _firebaseStorage.ref()
            .child('Post_Images/${Uuid().v4().toString()}')
            .putFile(file).whenComplete(() => null);
        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          url = downloadUrl.toString();
        });




      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }




  void submitForm() async{
    if (FormKey.currentState!.validate()) {
     await uploadImage();
      dynamic result =
          _data.savePost(url, desc, category);




      if (result == null) {
        print(result);
      }
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => UserProfilePage(),
      ),
    );
  }


  final FormKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    if(_image == null)
      getImageGallery();
    else
      null;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          toolbarHeight: 80,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blueGrey,
                child: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => HomePage1(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.black,
                  ),
                ),
              ),
              Text(
                'Imagine',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontFamily: 'DancingScript',
                ),
              ),
              SizedBox(
                height: 5,
                width: 5,
              )
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              width: double.maxFinite,
              height: 250,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20,),
                    width: 120,
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(_image),
                      ),
                    ),
                  ),
                  Form(
                    key: FormKey,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(5, 50, 5, 3),
                          height: 100,
                          width: 200,
                          child: TextFormField(
                            onChanged: (val) {
                              setState(() => desc = val.trim());
                            },

                            maxLines: 2,
                            scrollPadding: EdgeInsets.fromLTRB(5, 0, 5, 30),
                            decoration: InputDecoration(

                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: 'Description'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          height: 50,
                          width: 200,
                          child: TextFormField(
                            onChanged: (val) {
                              setState(() => category = val.trim());
                            },

                            maxLines: 1,
                            scrollPadding: EdgeInsets.all(10),
                            decoration: InputDecoration(

                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: 'Category'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  uploadImage();
                  submitForm();
                },
                child: Text('Post')
            ),
          ],
        ),
      ),
    );
  }
}
