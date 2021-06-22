import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:guitar_app/models/simple_user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on FirebaseUser
  SimpleUser? _simpleUserFromUser(User? user) {
    String email = ((user != null && user.email != null && user.email != '') ? user.email : '<No Email Provided>')!;
    String fullName = ((user != null && user.displayName != null && user.displayName != '') ? user.displayName : '<No Name Provided>')!;
    String description = '<No Description Provided>';  // add description field to user model in firebase
    DateTime createdTime = DateTime.fromMicrosecondsSinceEpoch(0);
    return user != null ? SimpleUser(uid: user.uid, createdTime: createdTime, email: email, fullName: fullName, description: description) : null;
  }

  // auth change user stream
  Stream<SimpleUser?> get user {
    return _auth.authStateChanges().map(_simpleUserFromUser);
    //.map((User? user) => _simpleUserFromUser(user));
  }

  // sign in anonymously
  Future signInAnon() async {
    try {
      UserCredential authResult = await _auth.signInAnonymously();
      User? user = authResult.user;
      return _simpleUserFromUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email & pw
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = authResult.user;
      return _simpleUserFromUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // register with email & pw
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = authResult.user;
      // create simple user in firebase
      if (user != null) {
        Map<String, dynamic> simpleUser = SimpleUser(uid: user.uid, createdTime: DateTime.now(), email: email).toJson();
        CollectionReference collectionReference = FirebaseFirestore.instance.collection('simple_users');
        await collectionReference.add(simpleUser);
      }
      else {
        print('SimpleUser wasn\'t added to Firestore because User returned from authResults was null');
      }
      return _simpleUserFromUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
