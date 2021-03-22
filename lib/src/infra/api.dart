import 'package:dio/dio.dart';
import 'package:flutter_web_app/src/infra/constants.dart';

class API {
  Dio dio;

  API() {
    this.dio = new Dio();
    this.dio.options.baseUrl = API_URL;
    this.dio.options.connectTimeout = 5000; //5s
    this.dio.options.receiveTimeout = 3000;
  }

  Dio getInstance() => this.dio;
}
