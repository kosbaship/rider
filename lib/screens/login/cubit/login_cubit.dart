import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rider/models/user.dart';
import 'package:rider/network/firebase_auth.dart';

import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  signUp({@required User user}) {
    emit(LoginLoadingState());

    FirebaseAuthService.signInEP(
            email: user.userEmail, password: user.userPassword)
        .then((userCredential) {
      print('= = = = = = = > ${userCredential.user.uid}');
      print('= = = = = = = > ${userCredential.user.email}');

      print('= = = = = = = > User Logged-In Successfully');
      emit(LoginSuccessState());
    }).catchError((e) {
      emit(LoginErrorState(e.toString()));
    });
  }
}
