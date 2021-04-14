import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:news/models/user.dart';
import 'package:news/repositories/repository.dart';

class AuthRepository extends Repository{
  final String baseUrl = 'auth';

  Future<User> register(User user) async {
    Map<String, dynamic> data = {
      "email": user.email,
      "first_name": user.name,
      "password": user.password,
      "password2": user.confirmPassword
    };
    Response response = await dio.post("$ipAddress/$baseUrl/register", data: jsonEncode(data));
    return User.fromJson(response.data);
  }
}