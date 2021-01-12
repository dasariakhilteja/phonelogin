import 'package:dummylogin/home.dart';
import 'package:dummylogin/login.dart';
import 'package:dummylogin/phoneauth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Login(),
        routes: {
          Home.routeName: (ctx) => Home(),
          PhoneAuth.routeName: (ctx) => PhoneAuth()
        });
  }
}
