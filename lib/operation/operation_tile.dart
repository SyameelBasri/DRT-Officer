import 'package:flutter/material.dart';
import 'package:realtime_ocr/models/operation.dart';
import 'operation_validation_result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OperationTile extends StatefulWidget {
  final String op_id;
  OperationTile({this.op_id});

  @override
  _OperationTileState createState() => _OperationTileState();
}

class _OperationTileState extends State<OperationTile> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: FutureBuilder(
        future: Firestore.instance.collection("Operation").document("operation_" + widget.op_id).get(),
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Container();
            break;
            default:
              if (snapshot.hasError)
                return Container(child: Text(snapshot.error.toString()));
              String location = snapshot.data["location"];
              String date = snapshot.data["date"];
              return Card(
                margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
                child: ListTile(
                    title: Text("Operation: " + widget.op_id + "\n" + location + "  " + date),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => OpValidationResult(op_id: widget.op_id,)));
                    }
                ),
              );
          }
        },
      ),
    );
  }
}
