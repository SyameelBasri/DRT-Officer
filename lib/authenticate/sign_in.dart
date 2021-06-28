import 'package:flutter/material.dart';
import 'package:realtime_ocr/services/auth.dart';
import 'package:realtime_ocr/shared/constant.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Color(0xff2b2b8e),
        title: Text("Sign In"),
        actions: [
          FlatButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text("Register"))
        ],
      ),
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
                RaisedButton(
                    color: Color(0xff2b2b8e),
                    child: Text(
                      "Sign In",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          loading = true;
                        });
                        dynamic res = await _auth.signInEmailPassword(
                            email, password);
                        if (res == null) {
                          setState(() {
                            loading = false;
                            error = "Invalid Sign In Credential";
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
