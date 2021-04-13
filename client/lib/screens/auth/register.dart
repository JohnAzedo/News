import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Criar conta'),
            TextField(
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Senha'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Confirmação de senha'),
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
