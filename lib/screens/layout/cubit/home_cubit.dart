
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

   LocationService.getCurrentLocationPosition().then((value) async{
     userCoordinates = Address(
       placeLatitude: LocationService.latitude,
       placeLongitude: LocationService.longitude,
     );

     await saveCurrentLocation();
     emit(HomeSuccessState());

    }).catchError((e) {
      emit(HomeErrorState(e.toString()));
    });
  }

  saveCurrentLocation(){


    ApiProvider.getAPIProviderInstance.fetchData(
      path: 'geocode/json?latlng=${userCoordinates.placeLatitude},${userCoordinates.placeLongitude}&key=$kMapKeyForIOS',
    ).then((response) {

      String customPlaceName, stNumber, cityName, governanceName ;
      stNumber = response.data['results'][0]['address_components'][0]['long_name'];
      cityName = response.data['results'][0]['address_components'][1]['long_name'];
      governanceName = response.data['results'][0]['address_components'][2]['long_name'];
      customPlaceName = '$stNumber, $cityName, $governanceName';

      userPickUpAddress = Address(
        placeLatitude: userCoordinates.placeLatitude,
        placeLongitude: userCoordinates.placeLongitude,
        placeName: customPlaceName,
      );

      print('\n================================================');
      print(userPickUpAddress.placeName);
      print(userPickUpAddress.placeLatitude);
      print(userPickUpAddress.placeLongitude);
      print('================================================\n');
      emit(HomeSuccessState());

    });
  }
}