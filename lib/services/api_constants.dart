import 'package:user_interface/constants.dart';

class ApiConstants {
  static ApiData locationIQ = ApiData(apiKey: 'da8137dd3c2ac6', baseUrl: 'https://us1.locationiq.com/v1/');
  static ApiData backend = ApiData(baseUrl: 'http://13.233.69.75:8000/');
}

class ApiData {
  final String? apiKey;
  final String? baseUrl;
  ApiData({this.apiKey,this.baseUrl});
}