import 'package:flutter/material.dart';
import 'package:rider/components/component.dart';

class HomePage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                'Login in as Rider',
                style: TextStyle(fontSize: 24.0, fontFamily: 'BoltSemiBold'),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultTextForm(
                        title: 'Email',
                        type: TextInputType.emailAddress,
                        controller: emailController),
                    defaultTextForm(
                        title: 'Password',
                        type: TextInputType.visiblePassword,
                        controller: passwordController),
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
                    Text(
                      'Don\'t have an account? ',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w100),
                    ),
                    Text(
                      ' SignUp Now',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 16),
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
