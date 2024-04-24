import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

TextEditingController _user = TextEditingController();
TextEditingController _pass = TextEditingController();

class CadasterUsers extends StatefulWidget {
  const CadasterUsers({super.key});

  @override
  State<CadasterUsers> createState() => _CadasterUsersState();
}

class _CadasterUsersState extends State<CadasterUsers> {
  String url = "http://10.109.83.13:3000/users";
  List data = [];
  var users = <Users>[];

  _post() {
    setState(() {
      Map<String, dynamic> message = {
        "user": "${_user.text}",
        "pass": "${_pass.text}"
      };
      http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(message),
      );
    });
  }

  _delete(String id) {
    print("delete $id");
    http.delete(Uri.parse(url + '/$id'));
  }

  _deleteUser() async {
    http.Response resposta = await http.get(Uri.parse(url));
    data = json.decode(resposta.body);
    for (int i = 0; i < data.length; i++) {
      if (data[i]["user"] == _user.text && data[i]["pass"] == _pass.text) {
        print("${data[i]["user"]} == ${_user.text}");
        print("${data[i]["pass"]} == ${_pass.text}");
        print("${data[i]["id"]}");
        _delete("${data[i]["id"].toString()}");
      }
    }
    setState(() {
      users = data.map((json) => Users.fromJson(json)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Usuários"),
        backgroundColor: Colors.blueAccent,
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
                    onPressed: _post,
                    icon: Icon(Icons.app_registration),
                    label: Text("Cadastrar")),
                ElevatedButton.icon(
                    onPressed: _deleteUser,
                    icon: Icon(Icons.delete),
                    label: Text("Deletar"))
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
