import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:realtime_ocr/services/database.dart';

class VehiclePage extends StatelessWidget {
  final String ve_reg_num;
  VehiclePage({this.ve_reg_num});

  @override
  Widget build(BuildContext context) {
    Map params = {"ve_reg_num": ve_reg_num};
    return Scaffold(
      appBar: AppBar(
        title: Text(ve_reg_num),
        backgroundColor: Color(0xff2b2b8e),
      ),
      body: FutureBuilder(
        future: fetch(params),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return Container(
              padding: EdgeInsets.fromLTRB(18, 18, 10, 10),
              child: Column(
                children: [
                  ListTile(
                    title: Text("Registration Number: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    subtitle: Text('  ' + snapshot.data["ve_reg_num"], style: TextStyle(fontSize: 18),),
                  ),
                  //Padding(padding: EdgeInsets.only(top: 5),),
                  ListTile(
                    title: Text("Expiry Date: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    subtitle: Text('  ' + snapshot.data["rt_expiry_dt"], style: TextStyle(fontSize: 18),),
                  ),
                  //Padding(padding: EdgeInsets.only(top: 5),),
                  ListTile(
                    title: Text("Region: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    subtitle: Text('  ' + snapshot.data["ve_region"], style: TextStyle(fontSize: 18),),
                  ),
                  //Padding(padding: EdgeInsets.only(top: 5),),
                  ListTile(
                    title: Text("Car Make: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    subtitle: Text('  ' + snapshot.data["ve_make"], style: TextStyle(fontSize: 18),),
                  ),
                  //  Padding(padding: EdgeInsets.only(top: 5),),
                  ListTile(
                    title: Text("Car Model: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    subtitle: Text('  ' + snapshot.data["ve_model"], style: TextStyle(fontSize: 18),),
                  ),
                  //Padding(padding: EdgeInsets.only(top: 5),),
                  ListTile(
                    title: Text("Engine Capacity: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    subtitle: Text('  ' + snapshot.data["ve_engine_capacity"].toString(), style: TextStyle(fontSize: 18),),
                  ),
                  //Padding(padding: EdgeInsets.only(top: 5),),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      ),
    );
  }
}
