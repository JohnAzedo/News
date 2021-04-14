

import 'package:flutter/material.dart';
import 'package:news/components/customTextField.dart';
import 'package:news/screens/auth/register.dart';

class InviteCodeScreen extends StatefulWidget {
  @override
  _InviteCodeScreenState createState() => _InviteCodeScreenState();
}

class _InviteCodeScreenState extends State<InviteCodeScreen> {

  void navigateToRegister(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RegisterScreen(),
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
            Text('Código convite'),
            Text('Digite o código contive compartilhado com você'),
            CustomTextField(
              label: 'Código',
              icon: Icon(Icons.code),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward),
        onPressed: () => navigateToRegister(context),
      ),
    );
  }
}
