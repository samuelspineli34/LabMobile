import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_validator/email_validator.dart';
import 'package:ex/CampoTexto.dart';
import 'package:ex/WelcomePage.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    initialRoute: "/",
    onGenerateRoute: (settings) {
      if (settings.name == '/registro') {
        return MaterialPageRoute(
          builder: (context) => CampoTexto(),
        );
      } else if (settings.name == '/logado') {
        // Extract the email argument from settings.arguments
        final String email = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => WelcomePage(email: email),
        );
      }
      return null;
    },
  ));
}


class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

const List<String> list = <String>['Hemocentro', 'Doador']; //tipos de usuario

class DropdownButtonApp extends StatelessWidget {
  const DropdownButtonApp({Key? key});

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
  const DropdownButtonExample({Key? key});

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
        ),
      ),
    );
  }
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

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
        body: IndexedStack(
          index: _currentIndex,
          children: [HomePage(), AboutPage()],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: _currentIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.app_registration),
              label: 'Login',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            )
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  String _errorMessage = "";
  String _errorSenha = "";

  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  void _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  contentPadding: EdgeInsets.all(10.0),
                ),
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
                  contentPadding: EdgeInsets.all(10.0),
                ),
                style: TextStyle(color: Colors.black, fontSize: 20),
                obscureText: true,
                controller: _passwordController,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(100, 10, 100, 0),
              child: ElevatedButton(
                child: const Text('Login', textAlign: TextAlign.center),
                onPressed: () {
                  validateLogin();
                },
              ),
            ),
            const Text(
              'Primeiro acesso?',
              style: TextStyle(color: Colors.black, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  child: const Text(
                    'Criar conta',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/registro");
                  },
                ),
                Container(
                  child: AlertDialog(
                    title: Text(_errorMessage),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void validateEmail(String val) {
    print(_errorMessage);
    if (val.isEmpty) {
      setState(() {
        _errorMessage = "E-mail não pode ser vazio";
      });
    } else if (!EmailValidator.validate(val, true)) {
      setState(() {
        _errorMessage = "E-mail ou senha inválidos";
      });
    } else {
      // Retrieve the stored email from SharedPreferences
      String storedEmail = _prefs?.getString('email') ?? '';

      if (val == storedEmail) {
        setState(() {
          _errorMessage = "Correto";
        });
      } else {
        setState(() {
          _errorMessage = "E-mail ou senha inválidos";
        });
      }
    }
  }

  void validateLogin() async {
    String enteredEmail = _textEditingController.text;
    String enteredPassword = _passwordController.text;

    if (enteredEmail.isEmpty || enteredPassword.isEmpty) {
      setState(() {
        _errorMessage = "E-mail ou senha inválidos";
      });
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String storedEmail = prefs.getString('email') ?? '';
      String storedPassword = prefs.getString('senha') ?? '';

      if (enteredEmail == storedEmail && enteredPassword == storedPassword) {
        Navigator.of(context).pushNamed("/logado", arguments: enteredEmail);
      } else {
        setState(() {
          _errorMessage = "E-mail ou senha inválidos";
        });
      }
    }
  }



}

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Container());
  }
}
