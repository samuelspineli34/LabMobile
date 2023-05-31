import 'package:flutter/material.dart';
import 'package:ex2/main.dart';

class CampoTexto extends StatefulWidget {
  @override
  _CampoTextoState createState() => _CampoTextoState();
}



class _CampoTextoState extends State<CampoTexto> {

  bool _isPasswordVisible = false;
  bool _isCheckedF = false;
  bool _isCheckedM = true;
  bool _mail = true;
  bool _celular = true;
  double _valorfonte = 15;
  String label = "";

  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrada de dados"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(16),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: "E-mail"),
              style: TextStyle(
                fontSize: _valorfonte,
                color: Colors.black,
              ),
              controller: _textEditingController,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(16),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Senha",
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        child: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    maxLength: 20,
                    obscureText: !_isPasswordVisible,
                    style: TextStyle(
                      fontSize: _valorfonte,
                      color: Colors.black,
                    ),
                    controller: _passwordController,
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Gênero: ', style: TextStyle(fontSize: _valorfonte)),
              Text('Masculino', style: TextStyle(fontSize: _valorfonte)),
              Radio(
                value: false,
                groupValue: _isCheckedM,
                onChanged: (valor) {
                  setState(() {
                    _isCheckedM = valor!;
                    _isCheckedF = valor;
                  });
                  print(valor);
                },
              ),
              Text('Feminino', style: TextStyle(fontSize: _valorfonte)),
              Radio(
                groupValue: _isCheckedF,
                value: true,
                onChanged: (valor) {
                  setState(() {
                    _isCheckedF = valor!;
                    _isCheckedM = valor;
                  });
                  print(valor);
                },
              ),
            ],
          ),
          Text('Notificações: ', style: TextStyle(fontSize: _valorfonte)),
          SwitchListTile(
              title: Text("E-mail", style: TextStyle(fontSize: _valorfonte)),
              value: _mail,
              onChanged: (bool valor) {
                setState(() {
                  _mail = valor;
                });
              }),
          SwitchListTile(
              title: Text("Celular", style: TextStyle(fontSize: _valorfonte)),
              value: _celular,
              onChanged: (bool valor) {
                setState(() {
                  _celular = valor;
                });
              }),
          Container(
              child: ElevatedButton(
            child: Text("Salvar", style: TextStyle(fontSize: _valorfonte)),
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
            ),
            onPressed: () {
              print("Texto digitado: " + _textEditingController.text);
            },
          )),
          Slider(
              value: _valorfonte,
              min: 15,
              max: 25,
              label: label,
              onChanged: (double novoValor)
              {
              setState(() {
                _valorfonte = novoValor;
                label = "seleção: " + novoValor.toString();
              });
              print("Valor selecionado: " + _valorfonte.toString());
              }
          )
        ],
      ),
    );
  }
}
