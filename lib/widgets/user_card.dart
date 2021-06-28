import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserCard extends StatefulWidget {
  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  FirebaseUser user;
  FirebaseAuth _auth;
  String uid;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _getCurrentUser();
  }

  _getCurrentUser () async {
    user = await _auth.currentUser();
    setState(() {
      uid = user.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.2,
      child: FutureBuilder(
        future: Firestore.instance.collection("User").document(uid).get(),
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            default:
              if (snapshot.hasError)
                return Container(child: Text(snapshot.error.toString()));
              String name = snapshot.data["name"] ?? "";
              String id_num = snapshot.data["id_num"] ?? "";
              String officer_rank = snapshot.data["officer_rank"] ?? "";
              return Card(
                color: Colors.lightBlue,
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 10),),
                    Icon(Icons.account_box, size: 120, color: Colors.white70,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(top: 30),),
                        Text("Officer Information", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
                        Padding(padding: EdgeInsets.only(top: 6),),
                        Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white)),
                        Padding(padding: EdgeInsets.only(top: 4),),
                        Text(id_num, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white)),
                        Padding(padding: EdgeInsets.only(top: 4),),
                        Text(officer_rank, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white))
                      ],
                    )
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}
