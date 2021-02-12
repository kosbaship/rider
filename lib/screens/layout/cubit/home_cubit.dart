
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rider/models/address.dart';
import 'package:rider/network/api_provider.dart';
import 'package:rider/services/location.dart';
import 'package:rider/shared/config_map.dart';

import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);



  Address userCoordinates = Address();
  Address userPickUpAddress = Address();
  
  getCurrentLocation() {
   emit(HomeLoadingState());

   LocationService.getCurrentLocationPosition().then((value) {
     userCoordinates = Address(
       placeLatitude: LocationService.latitude,
       placeLongitude: LocationService.longitude,
     );
     
     
     saveCurrentLocation();

      emit(HomeSuccessState());
    }).catchError((e) {
      emit(HomeErrorState(e.toString()));
    });
  }

  saveCurrentLocation(){
    ApiProvider.getAPIProviderInstance.fetchData(
      lat: userCoordinates.placeLatitude,
      long: userCoordinates.placeLongitude,
      mapKey: kMapKeyForIOS,
    ).then((value) {

      userPickUpAddress = Address(
        placeLatitude: userCoordinates.placeLatitude,
        placeLongitude: userCoordinates.placeLongitude,
        placeName: value.data['results'][0]['formatted_address'],
      );
      
      print('\n================================================');
      print(userPickUpAddress.placeLatitude);
      print(userPickUpAddress.placeLongitude);
      print(userPickUpAddress.placeName);
      print('================================================\n');
    });
  }
}