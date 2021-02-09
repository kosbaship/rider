import 'package:geolocator/geolocator.dart';

class LocationService{
  static  double latitude;
  static double longitude;

 static Future<void> getCurrentLocationPosition() async {
    try{
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch(e){
      print(e);
    }
  }
}