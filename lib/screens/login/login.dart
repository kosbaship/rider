import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rider/screens/signup/signup.dart';
import 'package:rider/shared/colors.dart';
import 'package:rider/shared/component.dart';

class LoginPage extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  final String email;
  final String password;

  LoginPage({this.email, this.password});

  @override
  Widget build(BuildContext context) {
    if (email != null && password != null) {
      emailController.text = email;
      passwordController.text = password;
    }
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
                child: Hero(
                  tag: 'inOutHeroTag',
                  child: Image(
                    image: AssetImage('assets/images/logo1.png'),
                    width: 390.0,
                    height: 250.0,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              Text(
                'Login as Rider',
                style: TextStyle(fontSize: 20.0, fontFamily: "Muli", fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 35.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric( horizontal: 20),
                child: Column(
                  children: [
                    buildTextField(
                        title: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        icon: Icons.email),
                    SizedBox(
                      height: 20.0,
                    ),
                    buildTextField(
                        title: 'Password',
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordController,
                        icon: Icons.lock,
                        obscureText: true),
                  ],
                ),
              ),
              SizedBox(
                height: 35.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: buildButton(title: 'Login', onPressed: () {}),
              ),
              SizedBox(
                height: 18.0,
              ),
              FlatButton(
                onPressed: () {
                  navigateToReplaceMe(context, SignUpPage());
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
                        'Sign-Up Now',
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
