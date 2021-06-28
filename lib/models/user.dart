import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User {
  String _uid;
  String _email;
  String _name;
  String _id_num;
  String _officer_rank;
  final FirebaseAuth auth = FirebaseAuth.instance;

  static final User _userSingleton = User._initialize();

  factory User() {
    return _userSingleton;
  }
  User._initialize();

  Future setUserData() async{
    final FirebaseUser user = await auth.currentUser();
    _uid = user.uid;
    _email = await Firestore.instance.collection("User").document(user.uid)
        .get().then((value) => value.data["email"]);
    _name = await Firestore.instance.collection("User").document(user.uid)
        .get().then((value) => value.data["name"]);
    _id_num = await Firestore.instance.collection("User").document(user.uid)
        .get().then((value) => value.data["id_num"]);
    _officer_rank = await Firestore.instance.collection("User").document(user.uid)
        .get().then((value) => value.data["officer_rank"]);
  }


  String get uid=>_uid;
  String get email=>_email;
  String get name=>_name;
  String get id_num=>_id_num;
  String get officer_rank=>_officer_rank;
}
