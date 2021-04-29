import 'package:dio/dio.dart';

class Repository {
  final String ipAddress = 'https://djnewsletter.herokuapp.com';
  final Dio dio = new Dio();
}