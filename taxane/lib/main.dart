import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:taxane/screen/administration-foncier.dart';
import 'package:taxane/screen/home-laptop.dart';
import 'package:taxane/screen/login-laptop.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

late _MyAppState myAppState;

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() {
    myAppState = _MyAppState();
    return myAppState;
  }
}

class _MyAppState extends State<MyApp> {
  String titre = 'Taxane Info';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: titre,
      debugShowCheckedModeBanner: false,
      initialRoute: '/administration-foncier',
      routes: {
        '/home': (context) => HomeLaptop(),
        '/': (context) => LoginLaptop(),
        '/administration-foncier': (context) => AdministrationFoncier(),
      },
    );
  }
}
