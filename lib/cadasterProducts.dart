import 'package:flutter/material.dart';
import 'package:formativa/products.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

TextEditingController _name = TextEditingController();
TextEditingController _price = TextEditingController();
TextEditingController _quant = TextEditingController();

class CadasterProducts extends StatefulWidget {
  const CadasterProducts({super.key});

  @override
  State<CadasterProducts> createState() => _CadasterProductsState();
}

class _CadasterProductsState extends State<CadasterProducts> {
  String url = "http://10.109.83.13:3000/products";

  _post() {
    setState(() {
      Map<String, dynamic> message = {
        "user": "${_name.text}",
        "price": "${_price.text}",
        "quant": "${_quant.text}"
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Produtos"),
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
                      labelText: "Produto",
                      labelStyle:
                          TextStyle(color: Colors.black, fontFamily: 'Poppins'),
                      hintText: 'Digite o Nome do Produto',
                      prefixIcon: Icon(Icons.shopping_bag),
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
                    controller: _name,
                  ),
                  SizedBox(height: 15),
                  TextField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: "Valor",
                      labelStyle:
                          TextStyle(color: Colors.black, fontFamily: 'Poppins'),
                      hintText: 'Digite o Valor do Produto',
                      prefixIcon: Icon(Icons.price_change),
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
                    controller: _price,
                  ),
                  SizedBox(height: 15),
                  TextField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: "Quantidade",
                      labelStyle:
                          TextStyle(color: Colors.black, fontFamily: 'Poppins'),
                      hintText: 'Digite a Quantidade do Produto',
                      prefixIcon: Icon(Icons.onetwothree),
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
                    controller: _quant,
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
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Products(),
                          ));
                    },
                    icon: Icon(Icons.shopping_cart),
                    label: Text("Produtos"))
              ],
            ),
          )
        ],
      ),
    );
  }
}
