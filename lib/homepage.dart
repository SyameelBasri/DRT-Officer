import 'package:flutter/material.dart';
import 'widgets/home_grid.dart';
import 'widgets/user_card.dart';
import 'package:realtime_ocr/services/auth.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>{

  final AuthService _auth = AuthService();

  final appTitle = 'Digital Road Tax';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
          backgroundColor: Color(0xff2b2b8e),
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app, color: Colors.white, size: 30,),
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            UserCard(),
            HomeGrid(),
          ],
        ),
      );
  }
}