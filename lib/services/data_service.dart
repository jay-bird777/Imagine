
import 'package:firebase_database/firebase_database.dart';
import 'package:my_app/models/post.dart';
import 'package:uuid/uuid.dart';

class DataService {
  final connection = FirebaseDatabase.instance.reference();

  //save user

  Future<void> saveUser(user) async {
    final userRef = connection.child('users').child(user.uid);
    userRef.set({
      'uid': user.uid,
      'email': user.email,
    });
  }

  //savepost
  Future<Post> savePost(url, desc, category) async {
    var id = Uuid().v1();
    final postRef = connection.child('Post').child(id);
    postRef
        .set({'uid': id, 'url': url, 'desc': desc, 'category': category});
    print('user uploaded!!');
    return Post(url: url, desc: desc, category: category, uid: id,);
  }
}
