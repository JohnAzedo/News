import 'package:flutter/material.dart';

class User{
  int id;
  String email;
  String name;
  String password;
  String confirmPassword;

  User({
    this.id,
    @required this.email,
    @required this.name,
    this.password,
    this.confirmPassword
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        name = json['name'];
}