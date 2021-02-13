import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiProvider {
  static ApiProvider getAPIProviderInstance = ApiProvider();

   Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://maps.googleapis.com/maps/api/',
    ),
  );

  Future<Response> fetchData({@required String path}) async {
    return await dio.post(path);
  }

}