import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rider/models/user.dart';
import 'package:rider/network/firebase_auth.dart';
import 'package:rider/network/realtime_database.dart';
import 'package:rider/screens/signup/cubit/signup_states.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitialState());

  static SignUpCubit get(context) => BlocProvider.of(context);

  signUp({@required User user}) {
    emit(SignUpLoadingState());

    FirebaseAuthService.signUpEP(
            email: user.userEmail, password: user.userPassword)
        .then((userCredential) {
      print('= = = = = = = > ${userCredential.user.uid}');
      print('= = = = = = = > ${userCredential.user.email}');

      FirebaseRealTimeDatabaseService.storeUsers(
          user: User(
              userID: userCredential.user.uid,
              userName: user.userName,
              userEmail: user.userEmail,
              userPhone: user.userPhone,
              userPassword: user.userPassword));
      print('= = = = = = = > User Stored Successfully');
      emit(SignUpSuccessState());
    }).catchError((e) {
      emit(SignUpErrorState(e.toString()));
    });
  }
}
