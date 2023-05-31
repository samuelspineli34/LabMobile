import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';



class WelcomePage extends StatelessWidget {
  final String email;

  const WelcomePage({required this.email});

  String getUserName() {
    List<String> parts = email.split('@');
    return parts[0];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem-vindo'),
      ),
      body: Center(
        child: Text('Bem-vindo, ${getUserName()}!'),
      ),
    );
  }
}
