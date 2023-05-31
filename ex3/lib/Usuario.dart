import 'package:flutter/material.dart';
import 'package:ex/main.dart';
import 'package:email_validator/email_validator.dart';

class Usuario extends StatefulWidget {
  String? valor;
  Usuario(String this.valor);

  @override
  _Usuario createState() => _Usuario();
}

class _Usuario extends State<Usuario> {

  @override
  Widget build(BuildContext context) {
    String valor = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
        appBar: AppBar(
          title: Text("Bem vindo ${valor}"),
        ),
        body: Column(
            children: <Widget>[
        Container(

        ),
      ],
    ),
    );
  }
}