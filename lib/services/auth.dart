import 'package:realtime_ocr/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:realtime_ocr/services/firestore.dart';
import 'firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj
  User _userFromFirebaseUser(FirebaseUser user) {
    User userSingleton = new User();
    return user != null ? userSingleton : null;
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }


  //email password sign in
  Future signInEmailPassword(String email, String password) async {
    try {
      AuthResult res = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = res.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //email password register
  Future registerEmailPassword(String email, String password, String name, String  id_num, String officer_rank) async {
    try {
      AuthResult res = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = res.user;

      //create new user document in firestore
      await FirestoreService().updateUserData(user.uid, email, name, id_num, officer_rank);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
