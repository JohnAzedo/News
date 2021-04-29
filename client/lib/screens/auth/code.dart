import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/components/customTextField.dart';
import 'package:news/screens/auth/register.dart';

class InviteCodeScreen extends StatefulWidget {
  @override
  _InviteCodeScreenState createState() => _InviteCodeScreenState();
}

class _InviteCodeScreenState extends State<InviteCodeScreen> {
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
                label: 'Código',
                icon: Icon(Icons.code),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward),
        onPressed: () => navigateToRegister(context),
      ),
    );
  }
}
