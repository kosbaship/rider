
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rider/services/location.dart';

import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  double cubitLatitude;
  double cubitLongitude;

  getCurrentLocation() {
   emit(HomeLoadingState());

   LocationService.getCurrentLocationPosition().then((value) {
     cubitLatitude = LocationService.latitude;
     cubitLongitude = LocationService.longitude;

      emit(HomeSuccessState());
    }).catchError((e) {
      emit(HomeErrorState(e.toString()));
    });
  }
}