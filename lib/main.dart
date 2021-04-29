import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:news/screens/news/list.dart';
import 'package:news/screens/splash.dart';
import 'package:news/screens/tabs.dart';

void main() => runApp(NewsApp());

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Jiffy.locale("pt");
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: CustomSplashScreen(),
      routes: {
        "/listNews": (_) => new TabsScreen(),
      },
    );
  }
}
