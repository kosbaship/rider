
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  signUp() {
   // emit(HomeLoadingState());

    // FirebaseAuthService.signInEP(
    //     email: user.userEmail, password: user.userPassword)
    //     .then((userCredential) {
    //   print('= = = = = = = > ${userCredential.user.uid}');
    //   print('= = = = = = = > ${userCredential.user.email}');
    //
    //   print('= = = = = = = > User Logged-In Successfully');
    //   emit(HomeSuccessState());
    // }).catchError((e) {
    //   emit(HomeErrorState(e.toString()));
    // });
  }
}