import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rider/components/colors.dart';
import 'package:rider/components/component.dart';
import 'package:rider/screens/layout/home.dart';

class SignUpPage extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
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
                'Sign-Up as Rider',
                style: TextStyle(fontSize: 20.0, fontFamily: "Muli", fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    buildTextField(
                        title: 'Name',
                        controller: nameController,
                        icon: Icons.person,),
                    SizedBox(
                      height: 20.0,
                    ),
                    buildTextField(
                        title: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        icon: Icons.email),
                    SizedBox(
                      height: 20.0,
                    ),
                    buildTextField(
                      title: 'Phone',
                      controller: phoneController,
                      icon: Icons.phone_android,),
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
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: buildButton(title: 'Sign Up', onPressed: () {}),
              ),
              SizedBox(
                height: 10.0,
              ),
              FlatButton(
                onPressed: () {
                  navigateToReplaceMe(context, HomePage());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        'Already have an account',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: kSecondaryColor, fontWeight: FontWeight.w100),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Login Now',
                        style: TextStyle(
                            color: kSecondaryColor,
                            fontWeight: FontWeight.w900,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
