import 'package:flutter/material.dart';
import 'package:news/models/token.dart';
import 'package:news/repositories/auth.dart';
import 'package:news/screens/auth/login.dart';
import 'package:news/screens/news/list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

class CustomSplashScreen extends StatelessWidget {
  final AuthRepository repository = AuthRepository();
  final String errorToken =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjE4MjcwODc2LCJqdGkiOiIwMmYyZjJlOTQ5MWE0NGUyYmM1M2NiYjMwNDM5MWQ3NCIsInVzZXJfaWQiOjV9.ObCSKC_Dj6x93RgY-STjPGuYw1hfStLuFKb3Byaa50k";
  bool logged;

  Future<dynamic> alreadyLogged() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final Token token = Token(
      access: preferences.getString('token_access'),
      refresh: preferences.getString('token_refresh'),
    );

    await repository.verifyToken(token).then((isValid) {
      logged = isValid;
    }).catchError((onError) {
      logged = false;
    });

    await repository.refreshToken(token).then((token) {
      logged = true;
    }).catchError((onError) {
      logged = false;
    });

    if (logged) {
      return ListNews();
    }

    return LoginScreen();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterFuture: alreadyLogged(),
      image: Image.asset('assets/images/icon.png'),
      backgroundColor: Theme.of(context).primaryColor,
      useLoader: true,
    );
  }
}
