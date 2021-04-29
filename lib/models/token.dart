import 'package:flutter/material.dart';

class Token{
  String access;
  String refresh;

  Token({
    @required this.access,
    @required this.refresh,
  });

  Token.fromJson(Map<String, dynamic> json)
      : access = json['access'],
        refresh = json['refresh'];
}