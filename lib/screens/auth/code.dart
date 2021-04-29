import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/components/customTextField.dart';
import 'package:news/repositories/auth.dart';
import 'package:news/screens/auth/register.dart';

class InviteCodeScreen extends StatefulWidget {
  @override
  _InviteCodeScreenState createState() => _InviteCodeScreenState();
}

class _InviteCodeScreenState extends State<InviteCodeScreen> {
  final _controller = TextEditingController();
  final repository = AuthRepository();

  Future<void> _checkInviteCode(BuildContext context, String code) async {
    return repository.checkInviteCode(code).then((isValid) {
      navigateToRegister(context);
    }).catchError((onError) {
      debugPrint(onError.toString());
      showInvalidCodeSnackBar(context);
    });
  }

  void fabPressed(BuildContext context) async {
    String code = _controller.text;
    if (code.length >= 8) {
      _checkInviteCode(context, code.toUpperCase());
    }
  }

  void navigateToRegister(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RegisterScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Conta 1/2'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                'Para iniciar seu cadastro, digite abaixo o código do convite compartilhado com você.',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  color: Colors.blue,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 24),
              CustomTextField(
                controller: _controller,
                label: 'Código',
                icon: Icon(Icons.code),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward),
        onPressed: () => fabPressed(context),
      ),
    );
  }

  void showInvalidCodeSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Código inválido'),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
