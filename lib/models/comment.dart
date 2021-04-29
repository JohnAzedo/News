import 'package:flutter/cupertino.dart';

class Comment {
  int id;
  String text;
  String author;
  DateTime date;

  Comment({this.id, @required this.text, this.author, this.date});

  Comment.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        text = json['text'],
        author = json['user'],
        date = DateTime.parse(json['created_at'].toString());
}
