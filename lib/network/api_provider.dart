import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiProvider {
  static ApiProvider getAPIProviderInstance = ApiProvider();

   Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://maps.googleapis.com/',
    ),
  );

   Future<Response> fetchData({@required lat,@required long,@required mapKey}) async {
    return await dio.post('maps/api/geocode/json?latlng=$lat,-$long&key=$mapKey');
  }
}