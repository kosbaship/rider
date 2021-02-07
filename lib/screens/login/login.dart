import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rider/models/user.dart';
import 'package:rider/screens/layout/home.dart';
import 'package:rider/screens/signup/signup.dart';
import 'package:rider/shared/colors.dart';
import 'package:rider/shared/component.dart';

import 'cubit/login_cubit.dart';
import 'cubit/login_states.dart';

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
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginLoadingState) {
            buildProgressDialog(
              context: context,
              text: 'please wait ...',
            );
          }

          if (state is LoginSuccessState) {
            Navigator.pop(context);
            navigateAndFinish(
              context,
              HomePage(),
            );
            showToast(message: 'Login is Successful', error: false);
          }

          if (state is LoginErrorState) {
            // close the progress dialog in the last state
            Navigator.pop(context);
            buildProgressDialog(
              context: context,
              text: "This account not found",
              error: true,
            );
          }
        },
        builder: (context, state) {
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
                      child: buildButton(title: 'Login', onPressed: () {
                        String email = emailController.text.trim();
                        String password = passwordController.text.trim();

                        _checkValidationAndSignIN(
                          context: context,
                          email: email,
                          password: password,
                        );
                      }),
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
        },
      ),
    );
  }
}

void _checkValidationAndSignIN({BuildContext context, String email, String password}) {
  // check if the field are empty
  if ( email.isEmpty || password.isEmpty) {
    showToast(message: 'please enter your data', error: true);
  } else {
    // check every fields validation
    if (!email.contains('@')) {
      showToast(message: 'please, enter a valid email', error: true);
    } else if (password.length > 6) {
      showToast(message: 'password must be at least 3 Characters', error: true);
    }
    // register the user
    LoginCubit.get(context).signUp(
        user: User(
            userEmail: email,
            userPassword: password
        )
    );
  }
}
