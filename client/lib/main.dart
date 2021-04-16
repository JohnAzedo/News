import 'package:flutter/material.dart';
import 'package:news/screens/auth/login.dart';
import 'package:news/screens/news/list.dart';

void main() => runApp(NewsApp());

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ListNews(),
    );
  }
}
