import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rider/components/colors.dart';
import 'package:rider/components/component.dart';
import 'package:rider/screens/signup/signup.dart';

class HomePage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kForthColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              SizedBox(
                height: 35.0,
              ),
              Center(
                child: Image(
                  image: AssetImage('assets/images/logo.png'),
                  width: 390.0,
                  height: 250.0,
                  alignment: Alignment.center,
                ),
              ),
              Text(
                'Rider Layout',
                style: TextStyle(fontSize: 20.0, fontFamily: "Muli", fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
