import 'package:flutter/material.dart';
import 'package:news/components/customTextField.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text('Criar conta'),
            CustomTextField(
              controller: _nameController,
              label: 'Nome',
              icon: Icon(Icons.person),
            ),
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
            CustomTextField(
              controller: _confirmPasswordController,
              isPassword: true,
              label: 'Confirmar senha',
              icon: Icon(Icons.lock),
            ),
            ElevatedButton(
              onPressed: () => {
                
              },
              child: Text('Criar'),
            )
          ],
        ),
      ),
    );
  }
}
