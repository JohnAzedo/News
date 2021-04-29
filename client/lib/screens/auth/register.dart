import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/components/customTextField.dart';
import 'package:news/models/token.dart';
import 'package:news/models/user.dart';
import 'package:news/repositories/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthRepository repository = AuthRepository();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void onPressedButton(BuildContext context) {
    if (_nameController.text != '' &&
        _emailController.text != '' &&
        _passwordController.text != '' &&
        _confirmPasswordController != '') {
      if (_passwordController.text == _confirmPasswordController.text) {
        if (_passwordController.text.length >= 8) {
          _createUser(context);
        } else {
          showWeakPasswordSnackBar(context);
        }
      } else {
        showWrongConfirmPasswordSnackBar(context);
      }
    } else {
      showCheckNullValuesSnackBar(context);
    }
  }

  Future<void> _createUser(BuildContext context) async {
    final User user = User(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        confirmPassword: _passwordController.text);

    return repository
        .register(user)
        .then((value) => {
              _getTokens(
                  context, User(email: user.email, password: user.password))
            })
        .catchError((onError) {
      showEmailErrorSnackBar(context);
    });
  }

  Future<void> _getTokens(BuildContext context, User user) async {
    return repository.login(user).then((token) {
      _saveToken(token);
      navigateToNews(context);
    }).catchError((onError) {});
  }

  void _saveToken(Token token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('token_access', token.access);
    await preferences.setString('token_refresh', token.refresh);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Conta 2/2'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  'Agora precisamos de algumas informações para finalizar seu cadastro.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 24),
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 24.0),
                  child: Text(
                    'As senhas devem conter pelo menos 8 letras, pelo menos 1 caractere e não podem ser comuns.',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.openSans(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(
                  height: 46,
                  width: Size.infinite.width,
                  child: ElevatedButton(
                    onPressed: () => onPressedButton(context),
                    child: Text(
                      'Criar conta',
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void navigateToNews(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil('/listNews', (_) => false);
  }

  void showCheckNullValuesSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Por favor, preencha todos os campos.'),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showWrongConfirmPasswordSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('As senhas não coincidem!'),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showEmailErrorSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Email ou senha inválidas'),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showWeakPasswordSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Senha fraca!'),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
