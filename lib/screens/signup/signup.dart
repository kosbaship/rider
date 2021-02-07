import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rider/models/user.dart';
import 'package:rider/screens/login/login.dart';
import 'package:rider/screens/signup/cubit/signup_cubit.dart';
import 'package:rider/screens/signup/cubit/signup_states.dart';
import 'package:rider/shared/colors.dart';
import 'package:rider/shared/component.dart';

class SignUpPage extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpStates>(
        listener: (context, state) {
          if (state is SignUpLoadingState) {
            buildProgressDialog(
              context: context,
              text: 'please wait ...',
            );
          }

          if (state is SignUpSuccessState) {
            // close the progress dialog in the last state
            Navigator.pop(context);
            navigateToReplaceMe(
              context,
              LoginPage(
                email: emailController.text,
                password: passwordController.text,
              ),
            );
            showToast(message: 'User Created Successfully', error: false);
          }

          if (state is SignUpErrorState) {
            // close the progress dialog in the last state
            Navigator.pop(context);
            buildProgressDialog(
              context: context,
              text: "This account is already exist",
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
                          width: 280.0,
                          height: 140.0,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                    Text(
                      'Sign-Up as Rider',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "Muli",
                          fontWeight: FontWeight.bold),
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
                            icon: Icons.person,
                          ),
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
                            icon: Icons.phone_android,
                          ),
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
                      child: buildButton(
                          title: 'Sign Up',
                          onPressed: () {
                            String name = nameController.text.trim();
                            String email = emailController.text.trim();
                            String phone = phoneController.text.trim();
                            String password = passwordController.text.trim();

                            _checkValidationAndSignUP(
                              context: context,
                              name: name,
                              email: email,
                              phone: phone,
                              password: password,
                            );
                          }),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    FlatButton(
                      onPressed: () {
                        navigateToReplaceMe(context, LoginPage());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              'Already have an account',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: kSecondaryColor,
                                  fontWeight: FontWeight.w100),
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
        },
      ),
    );
  }
}

void _checkValidationAndSignUP({
  @required BuildContext context,
  @required String name,
  @required String email,
  @required String phone,
  @required String password,
}) {
  // check if the field are empty
  if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
    showToast(message: 'please enter your data', error: true);
  } else {
    // check every fields validation
    if (name.length < 3) {
      showToast(message: 'name must be at least 3 Characters', error: true);
    } else if (!email.contains('@')) {
      showToast(message: 'please, enter a valid email', error: true);
    } else if (password.length > 6) {
      showToast(message: 'password must be at least 3 Characters', error: true);
    }
    // register the user
    SignUpCubit.get(context).signUp(
      user: User(
        userName: name,
        userEmail: email,
        userPhone: phone,
        userPassword: password
      )
    );
  }
}
