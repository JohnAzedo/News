import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/components/customTextField.dart';
import 'package:news/models/token.dart';
import 'package:news/models/user.dart';
import 'package:news/repositories/auth.dart';
import 'package:news/screens/news/list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'code.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthRepository repository = AuthRepository();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login(BuildContext context) {
    final User user = User(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (user.email != '' && user.password != '') {
      _getTokens(context, user);
    } else {
      showCheckNullValuesSnackBar(context);
    }
  }

  Future<void> _getTokens(BuildContext context, User user) async {
    return repository.login(user).then((token) {
      _saveToken(token);
      navigateToNews(context);
    }).catchError((onError) => showErrorAuthSnackBar(context));
  }

  void _saveToken(Token token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('token_access', token.access);
    await preferences.setString('token_refresh', token.refresh);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(height: 60),
                  Text(
                    'Bem vindo!',
                    style: GoogleFonts.openSans(
                      color: Colors.blue,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Por favor, faça login para continuar.',
                    style: GoogleFonts.openSans(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 36),
                  CustomTextField(
                    controller: _emailController,
                    label: 'Email',
                    icon: Icon(Icons.email),
                  ),
                  CustomTextField(
                    controller: _passwordController,
                    isPassword: true,
                    label: 'Senha',
                    icon: Icon(Icons.lock),
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    height: 40,
                    width: Size.infinite.width,
                    child: ElevatedButton(
                      onPressed: () => _login(context),
                      child: Text(
                        'Entrar',
                        style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Não possui conta ainda? ',
                    style: GoogleFonts.openSans(
                      color: Colors.black54,
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Cadastre-se',
                      style: GoogleFonts.openSans(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => navigateToInviteCode(context),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void showErrorAuthSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Email ou senha incorreto!'),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showCheckNullValuesSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Por favor, digite email e senha.'),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void navigateToInviteCode(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => InviteCodeScreen(),
      ),
    );
  }

  void navigateToNews(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ListNews(),
      ),
    );
  }
}
