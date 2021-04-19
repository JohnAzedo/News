import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:news/models/token.dart';
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
    Response response = await dio.post(
        "$ipAddress/$baseUrl/register",
        data: jsonEncode(data)
    );
    return User.fromJson(response.data);
  }

  Future<bool> emailAlreadyUsed(String email) async {
    Response response = await dio.get("$ipAddress/$baseUrl/used",
        queryParameters: {'email': email});
    return response.data['used'];
  }

  Future<bool> checkInviteCode(String code) async {
    Response response = await dio.get("$ipAddress/$baseUrl/invite/$code");
    return response.statusCode == 200;
  }

  Future<Token> login(User user) async{
    Map<String, dynamic> data = {
      "username": user.email,
      "password": user.password
    };

    Response response = await dio.post(
        "$ipAddress/$baseUrl/api/token",
        data: jsonEncode(data)
    );

    return Token.fromJson(response.data);
  }

  Future<bool> verifyToken(Token token) async {
    Map<String, dynamic> data = {
      "token": token.access
    };

    Response response = await dio.post(
      "$ipAddress/$baseUrl/api/token/verify",
      data: jsonEncode(data)
    );

    return response.statusCode == 200;
  }

  Future<Token> refreshToken(Token token) async {
    Map<String, dynamic> data = {
      "refresh": token.refresh
    };

    Response response = await dio.post(
        "$ipAddress/$baseUrl/api/token/refresh",
        data: jsonEncode(data)
    );

    token.access = response.data['access'];
    return token;
  }

}