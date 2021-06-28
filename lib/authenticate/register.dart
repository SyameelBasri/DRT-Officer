import 'package:flutter/material.dart';
import 'package:realtime_ocr/services/auth.dart';
import 'package:realtime_ocr/shared/constant.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

    //text field state
  String email = "";
  String password = "";
  String name =  "";
  String id_num =  "";
  String officer_rank = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
      backgroundColor: Colors.blue[50],
        appBar: AppBar(
        backgroundColor: Color(0xff2b2b8e),
        title: Text("Register"),
        actions: [
          FlatButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text("Sign In"))
        ],
      ),
      resizeToAvoidBottomPadding: false,
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  decoration:
                  textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (val) =>
                  val.isEmpty ? "Enter an Email" : null,
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration:
                  textInputDecoration.copyWith(hintText: 'Password'),
                  obscureText: true,
                  validator: (val) =>
                  val.isEmpty ? "Enter a Password" : null,
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration:
                  textInputDecoration.copyWith(hintText: 'Name'),
                  validator: (val) =>
                  val.isEmpty ? "Enter your Name" : null,
                  onChanged: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration:
                  textInputDecoration.copyWith(hintText: 'IC Number'),
                  validator: (val) =>
                  val.isEmpty ? "Enter your Identification Number" : null,
                  onChanged: (val) {
                    setState(() {
                      id_num = val;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration:
                  textInputDecoration.copyWith(hintText: 'Officer Rank'),
                  onChanged: (val) {
                    setState(() {
                      officer_rank = val;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                    color: Color(0xff2b2b8e),
                    child: Text(
                      "Register",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          loading = true;
                        });
                        dynamic res = await _auth.registerEmailPassword(
                            email, password, name, id_num, officer_rank);
                        if (res == null) {
                          setState(() {
                            loading = false;
                            error = "Invalid Input";
                          });
                        }
                      }
                    }),
                SizedBox(height: 12),
                Text(error,
                    style: TextStyle(color: Colors.red, fontSize: 14))
              ],
            ),
          )),
    );
  }
}
