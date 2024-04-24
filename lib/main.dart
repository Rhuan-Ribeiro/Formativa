import 'package:flutter/material.dart';
import 'package:formativa/cadasterProducts.dart';
import 'package:formativa/cadasterUsers.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

TextEditingController _user = TextEditingController();
TextEditingController _pass = TextEditingController();

void main() {
  runApp(MaterialApp(
    home: Login(),
  ));
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String url = "http://10.109.83.13:3000/users";
  List data = [];
  var users = <Users>[];

  _getLogin() async {
    http.Response resposta = await http.get(Uri.parse(url));
    data = json.decode(resposta.body);

    for (int i = 0; i < data.length; i++) {
      if (data[i]["user"] == _user.text && data[i]["pass"] == _pass.text) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CadasterProducts(),
            ));
      }
    }
    print("Dados Errados!");
    setState(() {
      // dado.map vai converter nosso json em uma lista
      users = data.map((json) => Users.fromJson(json)).toList();
    });

    // print(users);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Tela de Login"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: "Usuário",
                      labelStyle:
                          TextStyle(color: Colors.black, fontFamily: 'Poppins'),
                      hintText: 'Digite seu Nome',
                      prefixIcon: Icon(Icons.account_circle_outlined),
                      prefixIconColor: MaterialStateColor.resolveWith(
                          (states) => states.contains(MaterialState.focused)
                              ? Colors.black
                              : Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 2,
                        ),
                      ),
                    ),
                    cursorColor: Colors.grey,
                    controller: _user,
                  ),
                  SizedBox(height: 15),
                  TextField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: "Senha",
                      labelStyle:
                          TextStyle(color: Colors.black, fontFamily: 'Poppins'),
                      hintText: 'Digite sua senha',
                      prefixIcon: Icon(Icons.key_outlined),
                      prefixIconColor: MaterialStateColor.resolveWith(
                          (states) => states.contains(MaterialState.focused)
                              ? Colors.black
                              : Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 2,
                        ),
                      ),
                    ),
                    cursorColor: Colors.grey,
                    obscureText: true,
                    obscuringCharacter: "*",
                    controller: _pass,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 50),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                    onPressed: _getLogin,
                    icon: Icon(Icons.login),
                    label: Text("Login")),
                ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CadasterUsers(),
                          ));
                    },
                    icon: Icon(Icons.app_registration),
                    label: Text("Cadastrar"))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Users {
  String id;
  String name;
  String pass;
  Users(this.id, this.name, this.pass);
  // Função factory é a função responsável por decodificar o dado json consumido através da api
  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(json["id"], json["name"], json["pass"]);
  }
}
