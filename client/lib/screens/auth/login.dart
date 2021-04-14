import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:news/components/customTextField.dart';

import 'code.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  void navigateToInviteCode(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => InviteCodeScreen(),
      ),
    );
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
              label: 'Email',
              icon: Icon(Icons.email),
            ),
            CustomTextField(
              label: 'Senha',
              icon: Icon(Icons.lock),
            ),
            Row(
              children: [
                Text('Não possui conta ainda? '),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Theme.of(context).primaryColor
                    ),
                    text: 'Cadastre-se',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => navigateToInviteCode(context)
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
