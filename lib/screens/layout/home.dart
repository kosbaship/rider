import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rider/components/colors.dart';
import 'package:rider/components/component.dart';

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
                  image: AssetImage('assets/images/logo1.png'),
                  width: 390.0,
                  height: 250.0,
                  alignment: Alignment.center,
                ),
              ),
              Text(
                'Login as Rider',
                style: TextStyle(fontSize: 24.0, fontFamily: "Muli", fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultTextForm(
                        title: 'Email',
                        type: TextInputType.emailAddress,
                        controller: emailController,
                    icon: Icons.email),
                    SizedBox(
                      height: 35.0,
                    ),
                    defaultTextForm(
                        title: 'Password',
                        type: TextInputType.visiblePassword,
                        controller: passwordController,
                    icon: Icons.lock,
                    obscureText: true),


                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(18),
                child: defaultButton(title: 'Login', onPressed: () {}),
              ),
              FlatButton(
                onPressed: () {
                  print('f');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        'Don\'t have an account? ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: kSecondaryColor, fontWeight: FontWeight.w100),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'SignUp Now',
                        style: TextStyle(
                            color: kSecondaryColor,
                            fontWeight: FontWeight.w900,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
