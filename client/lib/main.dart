import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:news/screens/auth/login.dart';
import 'package:news/screens/news/list.dart';

void main() => runApp(NewsApp());

class NewsApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Jiffy.locale("pt");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ListNews(),
    );
  }
}
