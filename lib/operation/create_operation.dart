import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/firestore.dart';
import 'package:realtime_ocr/widgets/map.dart';

class CreateOperation extends StatefulWidget {
  @override
  _CreateOperationState createState() => _CreateOperationState();
}

class _CreateOperationState extends State<CreateOperation> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _textEditingController = TextEditingController();

  DateTime date;
  String strDate;
  String location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create New Operation"),
        backgroundColor: Color(0xff2b2b8e),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              buildDateField(),
              SizedBox(height: 20.0),
              buildLocationField(),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Color(0xff2b2b8e),
                child: Text(
                  "Create",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()){
                    await FirestoreService().createOperation(strDate, location);
                    //print('New Operation');
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 0)),
        lastDate: DateTime(2100));
    if (picked != null && picked != date) {
      setState(() {
        date = picked;
      });
    }
  }

  Widget buildDateField() {
    return TextFormField(
      controller: _textEditingController,
      onTap: () async {
        FocusScope.of(context).requestFocus(new FocusNode());
        await _selectDate(context);
        _textEditingController.text = DateFormat('dd/MM/yyyy').format(date);
        setState(() {
          strDate = _textEditingController.text;
          print(strDate);
        });
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Operation Date',
        contentPadding: EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 12.0,
        ),
      ),
      validator: (String value) {
        print('date:: ${date.toString()}');
        if (value.isEmpty) {
          return 'Operation Date is Required.';
        }
        return null;
      },
      // onSaved: (String val) {
      //   strDate = val;
      // },
    );
  }

  Widget buildLocationField() {
    return TextFormField(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Map()));
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Location',
        contentPadding: EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 12.0,
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Location is Required.';
        }
        return null;
      },
      onChanged: (String value) {
        setState(() {
          location = value;
        });
        //print(location);
      },
    );
  }
}
