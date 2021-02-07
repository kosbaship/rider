import 'package:flutter/material.dart';
import 'package:rider/screens/layout/home.dart';

import 'components/colors.dart';
import 'components/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Uber Rider',
      theme: theme(),
      home: HomePage(),
    );
  }
}


