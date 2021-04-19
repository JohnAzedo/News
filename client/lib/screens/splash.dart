import 'package:flutter/material.dart';
import 'package:news/models/token.dart';
import 'package:news/repositories/auth.dart';
import 'package:news/screens/auth/login.dart';
import 'package:news/screens/news/list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

class CustomSplashScreen extends StatelessWidget {
  final AuthRepository repository = AuthRepository();
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

    await repository.refreshToken(token).then((newToken) {
      logged = true;
      _saveToken(newToken);
    }).catchError((onError) {
      logged = false;
    });

    if (logged) {
      return ListNews();
    }
    return LoginScreen();
  }

  void _saveToken(Token token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('token_access', token.access);
    await preferences.setString('token_refresh', token.refresh);
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
