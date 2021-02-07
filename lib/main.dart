import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rider/screens/login/login.dart';
import 'package:rider/shared/component.dart';
import 'package:rider/shared/theme.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    initApp();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Uber Rider',
      theme: theme(),
      home: LoginPage(),
    );
  }
}


