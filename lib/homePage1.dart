
import 'dart:async';
import 'dart:io';


import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:my_app/loginPage.dart';
import 'package:my_app/seachBar.dart';
import 'package:my_app/uploadPage1.dart';
import 'package:my_app/userProfilePage.dart';
import 'homePage2.dart';
import 'landingPage.dart';
import 'postImage.dart';
import 'package:firebase_database/firebase_database.dart';

class HomePage1 extends StatefulWidget {
  HomePage1({Key? key}) : super(key: key);
  String id = 'homePage1';


  @override
  _HomePage1State createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  bool bookmarkPressed = false;
  double opacity = 0.0;
  bool starPressed = false;
  bool _homePage = true;
  int _currentIndex = 0;

  List<Post> postList = [];

  @override
  void initState()
  {
    // TODO: implement initState
    super.initState();
    var postsRef = FirebaseDatabase.instance.reference().child("Post");

    postsRef.once().then((DataSnapshot snap)
    {
      var KEYS = snap.value.keys;
      var DATA = snap.value;

      postList.clear();

      for(var individualKey in KEYS)
        {
          Post post = new Post
            (
              DATA[individualKey]['url'],
              DATA[individualKey]['desc'],
              DATA[individualKey]['category'],
            );
          
          postList.add(post);
        }

      setState(()
      {
        print('Length: $postList.length');
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          toolbarHeight: 80,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
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
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blueGrey,
                child: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.person_rounded,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Post',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => HomePage2(),
                      ),
                    );
                  },
                  child: Text(
                    'Maps',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
        child: Container(
          width: double.maxFinite,
          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: postList.length == 0
              ? Center(child: new Text('No post Available...'))
              : ListView.builder(
              reverse: true,
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              itemCount: postList.length,
              itemBuilder: (_, index){
                return PostUI(postList[index].url,postList[index].desc,postList[index].category,);
              }),
          )

        ),
          ],
        ),
           bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          iconSize: 25,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                backgroundColor: Colors.orangeAccent,
                title: Text('Home')),
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                backgroundColor: Colors.green,
                title: Text('Search')),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline),
                backgroundColor: Colors.lightBlueAccent,
                title: Text('Post')),
            BottomNavigationBarItem(
                icon: Icon(Icons.group_work_outlined),
                backgroundColor: Colors.redAccent,
                title: Text('Clan')),
            BottomNavigationBarItem(
                icon: Stack(
                  alignment: Alignment(
                    0,
                    -1.5,
                  ),
                  children: [
                    Icon(Icons.message_outlined),
                    if (_currentIndex != 4)
                      Align(
                        alignment: Alignment(
                          0.3,
                          0.2,
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 6.0,
                        ),
                      ),
                  ],
                ),
                backgroundColor: Colors.teal,
                title: Text('Messages')),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            if(index == 0 && _homePage == false)
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => HomePage1(),
                  )
              );
            if(index == 1)
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => SearchBar(),
                  )
              );
            if(index == 2)
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => UploadPage1(),
                  )
              );

          },
        ),
      ),
    );
  }

  Widget PostUI(String url, String desc, String category,)
  {

    return new GestureDetector(
      onDoubleTap: (){
        setState(() {
          bookmarkPressed = !bookmarkPressed;

        });
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 80,
              width: double.maxFinite,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey),
                color: Colors.blueGrey,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0), bottom: Radius.zero),
              ),
              child: Row(
                children: [
                  //contains the profile avatar
                  Container(
                    margin: EdgeInsets.all(15),
                    child: Stack(
                      alignment: Alignment(
                        1.5,
                        -1.0,
                      ),
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.blueAccent,
                          child: Icon(
                            Icons.person_rounded,
                            color: Colors.black,
                          ),
                        ),
                        CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  //contains username and clan name
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 10, 10, 5),
                        child: Text(
                          'EarthChild',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ),
                      //this stack is for the clan name and rank
                      Stack(
                        alignment: Alignment(
                          1.4,
                          0.0,
                        ),
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(12, 2, 0, 2),
                            child: Text(
                              'EarthGangFoxs',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 6,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(110, 0, 5, 0),
                    child: IconButton(
                        onPressed: (){
                          setState(() {
                            bookmarkPressed = !bookmarkPressed;
                          });
                        },
                        icon: bookmarkPressed

                            ? Icon(
                            Icons.bookmark
                        ) : Icon(
                            Icons.bookmark_outline
                        )
                    ),
                  ),
                ],
              ),
            ),
            //this container has the image inside
            Stack(
              alignment: Alignment(
                -0.1,
                -0.1,
              ),
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(url),
                    ),
                  ),
                  height: 440,
                  width: double.maxFinite,
                ),
                AnimatedOpacity(
                  opacity: 1.0,
                  duration: Duration(seconds: 1),
                  child: IconButton(
                    onPressed: (){
                      setState(() {
                        bookmarkPressed = !bookmarkPressed;
                      });
                    },
                    icon: bookmarkPressed

                        ? Icon(Icons.bookmark, color: Colors.white, size: 70,)
                        : Container(),

                  ),
                ),
              ],
            ),
            Container(
              height: 100,
              width: double.maxFinite,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey),
                color: Colors.blueGrey,
                borderRadius: BorderRadius.vertical(top: Radius.zero, bottom: Radius.circular(20.0)),
              ),
              child: Container(
                margin: EdgeInsets.all(15),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(desc,
                    maxLines: 3,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
