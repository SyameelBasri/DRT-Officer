import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'operation_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/FAB.dart';

class OperationPage extends StatefulWidget {
  @override
  _OperationPageState createState() => _OperationPageState();
}

class _OperationPageState extends State<OperationPage>{
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
    return StreamBuilder(
      stream: Firestore.instance.collection("User").document(uid).snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Operation"),
              backgroundColor: Color(0xff2b2b8e),
            ),
            floatingActionButton: FancyFab(),
            body: Center(
              child: Text("NO OPERATION"),
            ),
          );
        }

        switch(snapshot.connectionState){
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
            break;
          default:
            if (snapshot.hasError)
              return Container(child: Text(snapshot.error.toString()));
            var operations = snapshot.data["joined_operation"];
            //print(operations);
            return Scaffold(
              appBar: AppBar(
                title: Text("Operation"),
                backgroundColor: Color(0xff2b2b8e),
              ),
              floatingActionButton: FancyFab(),
              body: new ListView.builder(
                itemCount: operations.length,
                itemBuilder: (context, index) {
                  return OperationTile(op_id: operations[index].toString());
                },
              ),
            );
        }
      },
    );
  }
}
