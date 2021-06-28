import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:realtime_ocr/vehicle/vehicle_page.dart';

class OpValidationResult extends StatefulWidget {
  final String op_id;
  OpValidationResult({this.op_id});

  @override
  _OpValidationResultState createState() => _OpValidationResultState();
}

class _OpValidationResultState extends State<OpValidationResult> {

  String noCars = "No Validated Car";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Operation " + widget.op_id + ": Validated Cars"),
        backgroundColor: Color(0xff2b2b8e),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection("Operation").document("operation_" + widget.op_id).collection("Validation Result").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text(
              'No Data...',
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.documents[index];
                String expiry_date = ds["rt_expiry_dt"];
                return Card(
                  color: ds["rt_is_valid"] ? Colors.green[300] : Colors.red[500],
                  child: new ListTile(
                    leading: const Icon(Icons.time_to_leave,color: Colors.black,),
                    title: Text(ds["ve_reg_num"], style: TextStyle(fontSize: 18, color: Colors.black)),
                    subtitle: ds["rt_is_valid"] ? Text("VALID: $expiry_date", style: TextStyle(fontSize: 14, color: Colors.black),)
                        : Text("EXPIRED: $expiry_date", style: TextStyle(fontSize: 14, color: Colors.black)),
                    trailing: const Icon(Icons.arrow_forward, color: Colors.black,),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => VehiclePage(ve_reg_num: ds["ve_reg_num"])));
                    }
                  ),
                );
              },
            );
          }
        }
      ),
    );
  }
}
