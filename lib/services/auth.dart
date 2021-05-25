import 'package:firebase_auth/firebase_auth.dart';
import 'package:guitar_app/models/simple_user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on FirebaseUser
  SimpleUser? _simpleUserFromUser(User? user) {
    return user != null ? SimpleUser(uid: user.uid) : null;
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
  // ...

  // register with email & pw
  // ...

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
