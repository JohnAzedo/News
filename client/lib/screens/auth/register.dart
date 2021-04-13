import 'package:flutter/material.dart';
import 'package:news/components/textField.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text('Criar conta'),
            CustomTextField(
              label: 'Nome',
              icon: Icon(Icons.person),
            ),
            CustomTextField(
              label: 'Email',
              icon: Icon(Icons.email),
            ),
            CustomTextField(
              isPassword: true,
              label: 'Senha',
              icon: Icon(Icons.lock),
            ),
            CustomTextField(
              isPassword: true,
              label: 'Confirmar senha',
              icon: Icon(Icons.lock),
            ),
            ElevatedButton(
              onPressed: () => {},
              child: Text('Criar'),
            )
          ],
        ),
      ),
    );
  }
}
