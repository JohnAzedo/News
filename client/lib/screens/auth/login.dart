import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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

  void _handleAuthError() {}

  void _saveToken(Token token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('token_access', token.access);
    await preferences.setString('token_refresh', token.refresh);
  }

  Future<void> _login(BuildContext context) async {
    final User user = User(
      email: _emailController.text,
      password: _passwordController.text,
    );

    return repository.login(user).then((token) {
      _saveToken(token);
      navigateToNews(context);
    }).catchError((onError) {
      debugPrint('Teste');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Entrar'),
            Text('Por favor, faça login para continuar.'),
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
            ElevatedButton(
              onPressed: () => _login(context),
              child: Text('Entrar'),
            ),
            Row(
              children: [
                Text('Não possui conta ainda? '),
                RichText(
                  text: TextSpan(
                      style: TextStyle(color: Theme.of(context).primaryColor),
                      text: 'Cadastre-se',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => navigateToInviteCode(context)),
                )
              ],
            )
          ],
        ),
      ),
    );
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
