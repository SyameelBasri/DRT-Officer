import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_ocr/models/user.dart';
import 'package:realtime_ocr/authenticate/authenticate.dart';
import 'services/firestore.dart';
import 'homepage.dart';

//wrapper will return either home or authenticate
class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    User user = new User();
    user.setUserData();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context); //access the current user

    if (user == null) {
      return Authenticate();
    } else {
      return Homepage();
    }
  }
}