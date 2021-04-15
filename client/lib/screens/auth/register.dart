import 'package:flutter/material.dart';
import 'package:news/components/customTextField.dart';
import 'package:news/models/user.dart';
import 'package:news/repositories/auth.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthRepository repository = AuthRepository();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  Future<void> _createUser() async{
    final User user = User(
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      confirmPassword: _passwordController.text
    );

    return repository.register(user).then((value) => {
      debugPrint('Here')
    });
  }

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
              onPressed: () => _createUser(),
              child: Text('Criar'),
            )
          ],
        ),
      ),
    );
  }
}
