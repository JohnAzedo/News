import 'package:dio/dio.dart';

class Repository {
  final String ipAddress = 'http://192.168.1.12:8000';
  final Dio dio = new Dio();
}