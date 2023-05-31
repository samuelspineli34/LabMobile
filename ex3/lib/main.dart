import 'package:flutter/material.dart';
import 'package:ex/CampoTexto.dart';
import 'package:ex/Usuario.dart';
//import 'EntradaCheckBox.dart';
import 'package:email_validator/email_validator.dart';

void main() {
  runApp(MaterialApp(home: HomePage(), initialRoute: "/",
      routes: {
        "/logado": (context) => Usuario("/logado"),
        "/registro": (context) => CampoTexto()
  }
  )
  );
}

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

const List<String> list = <String>['Hemocentro', 'Doador']; //tipos de usuario

class DropdownButtonApp extends StatelessWidget {
  const DropdownButtonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Scaffold(
        body: Center(
          child: DropdownButtonExample(),
        ),
      ),
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: DropdownButton<String>(
            alignment: Alignment.center,
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
              });
            },
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )),
    );
  }
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  _DropdownButtonExampleState _dropdownButtonExampleState =
  _DropdownButtonExampleState();

  List<AppBar> appBarContent = [
    AppBar(title: const Text('Login')),
    AppBar(title: const Text('Notícias')),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Login',
        home: Scaffold(
            appBar: appBarContent[_currentIndex],
            //drawer: const Drawer(),
            body: IndexedStack(index: _currentIndex, children: [
              HomePage(),
              AboutPage()
            ]),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              currentIndex: _currentIndex,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.app_registration),
                  label: 'Login',
                ),
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home')
              ],
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            )));
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePage  createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  String _errorMessage = "";
  String _errorSenha = "";

  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
   // final screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            // Background
              //image: DecorationImage(
                //  image: AssetImage('assets/images/background.jpg'),
                //  fit: BoxFit.cover)
              ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(50, 0, 50, 25),
                color: Colors.white,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: 'E-mail',
                      contentPadding: EdgeInsets.all(10.0)),
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  controller: _textEditingController,
                  onChanged: (val) {
                    validateEmail(val);
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(50, 25, 50, 50),
                color: Colors.white,
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: 'Senha',
                      contentPadding: EdgeInsets.all(10.0)),
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  obscureText: true,
                  controller: _passwordController,
                  onChanged: (val) {
                    validateSenha(val);
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(100, 10, 100, 0),
                child: ElevatedButton(
                    child: const Text('Login', textAlign: TextAlign.center),
                    onPressed: () {
                      validateLogin(_textEditingController.text);
                    }),
              ),
              const Text('Primeiro acesso?',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  textAlign: TextAlign.center),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                      child: const Text(
                        'Criar conta',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        setState(() {
                          Navigator.of(context).pushNamed("/registro");}
                        );
                      }),
                  Container(
                    child: AlertDialog(
                        title: Text(_errorMessage)),
                  ),
                  Container(
                    child: AlertDialog(
                        title: Text(_errorSenha))
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void validateEmail(String val) {
    print(_errorMessage);
    if (val.isEmpty) {
      setState(() {
        _errorMessage = "Email can not be empty";
      });
    } else if (!EmailValidator.validate(val, true)) {
      setState(() {
        _errorMessage = "Invalid Email Address";
      });
    } else if (val == "eu@gmail.com") {
      setState(() {
        _errorMessage = "Correto";
      });
    }
  }

  void validateSenha(String val) {
    print(_errorSenha);
    if (val.isEmpty) {
      setState(() {
        _errorSenha = "Senha não pode ser vazia";
      });
    } else if (val == "1234") {
      setState(() {
        _errorSenha = "Correto";
      });
    }
  }

  void validateLogin(String val) {
    if (_errorSenha == "Correto" && _errorMessage == "Correto")
    {
      Navigator.of(context)
          .pushNamed("/logado", arguments: val);
    }
  }

}

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Container());
  }
}
