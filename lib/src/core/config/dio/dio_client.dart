import 'package:dio/dio.dart';

class DioClient {
  Map<String, String> commonHeader = {
    "Content-type": "application/json",
    "Accept": "application/json"
  };
  late Dio dio;

  DioClient() {
    dio = Dio()
      //10.0.2.2:8000
      ..options.baseUrl = "http://10.0.2.2:3000/api"
      ..options.headers = commonHeader;
  }
}
