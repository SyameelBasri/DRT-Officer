import 'package:flutter/material.dart';
import '../services/firestore.dart';


class JoinOperation extends StatefulWidget {
  @override
  _JoinOperationState createState() => _JoinOperationState();
}

class _JoinOperationState extends State<JoinOperation> {
  final _formKey = GlobalKey<FormState>();

  String op_id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Join Operation"),
        backgroundColor: Color(0xff2b2b8e),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              buildOperationIDField(),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Color(0xff2b2b8e),
                child: Text(
                  "Join",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()){
                    await FirestoreService().joinOperation(op_id);
                  }
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget buildOperationIDField() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Operation ID',
        contentPadding: EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 12.0,
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Operation ID is Required.';
        }
        return null;
      },
      onChanged: (String value) {
        setState(() {
          op_id = value;
        });
      },
    );
  }
}
