import 'package:dummylogin/phoneauth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final inputFocus = FocusNode();
  var _login = true;
  var _passwordfield = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _email = '';
  var _password = '';

  void formsubmitted() async {
    final auth = FirebaseAuth.instance;

    final _valid = _form.currentState.validate();
    try {
      if (_valid) {
        _form.currentState.save();
        UserCredential authResult;
        if (_login) {
          authResult = await auth.signInWithEmailAndPassword(
              email: _email.toString().trim(),
              password: _password.toString().trim());
          print(authResult);
          Navigator.of(context).pushNamed(Home.routeName);
        } else {
          authResult = await auth.createUserWithEmailAndPassword(
            email: _email,
            password: _password,
          );
          Navigator.of(context).pushNamed(Home.routeName);
        }
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[300],
        //  drawer: NavDrawer(),
        appBar: AppBar(
          title: Text("enter new data"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(50),
                child: Center(
                    child: Card(
                  color: Colors.deepOrange[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 8.0,
                  child: Center(
                    child: Container(
                      height: 350,
                      constraints: BoxConstraints(minHeight: 250),
                      width: 250,
                      padding: EdgeInsets.all(16.0),
                      child: Form(
                          key: _form,
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  decoration:
                                      InputDecoration(labelText: "username"),
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (value) {
                                    FocusScope.of(context)
                                        .requestFocus(inputFocus);
                                  },
                                  onSaved: (value) {
                                    _email = value;
                                  },
                                ),
                                TextFormField(
                                  decoration:
                                      InputDecoration(labelText: "password"),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  controller: _passwordfield,
                                  focusNode: inputFocus,
                                  onSaved: (value) {
                                    _password = value;
                                  },
                                ),
                                /*     if (!_login)
                                  TextFormField(
                                    decoration: InputDecoration(
                                        labelText: "conform password"),
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    onSaved: (value) {
                                      _conformpass = value;
                                    },
                                  ),*/
                                RaisedButton(
                                    onPressed: () {
                                      formsubmitted();
                                    },
                                    child: Text(_login ? "login" : "sign up")),
                                FlatButton(
                                    onPressed: () {
                                      setState(() {
                                        _login = !_login;
                                      });
                                    },
                                    child: Text(_login
                                        ? " create account"
                                        : "u already have account")),
                              ],
                            ),
                          )),
                    ),
                  ),
                )),
              ),
              Row(children: <Widget>[
                Text("phone authentication"),
                IconButton(
                    icon: Icon(
                      Icons.phone,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(PhoneAuth.routeName);
                    })
              ])
            ],
          ),
        ));
  }
}
