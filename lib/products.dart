import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  String url = "http://10.109.83.13:3000/products";
  List data = [];
  var products = <Produto>[];

  _get() async {
    http.Response response = await http.get(Uri.parse(url));

    data = json.decode(response.body);

    for (int i = 0; i < data.length; i++) {
      print(data[i]);
    }
    setState(() {
      products = data.map((json) => Produto.fromJson(json)).toList();
    });
    print("products:");
    print(products);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Products"),
        ),
        body: Column(
          children: [
            Column(
              children: products
                  .map((product) => Text(
                        "${product.price}",
                        style: TextStyle(fontSize: 18),
                      ))
                  .toList(),
            ),
            ElevatedButton(onPressed: _get, child: Icon(Icons.abc))
          ],
        ));
  }
}

class Produto {
  String id;
  String product;
  double price;
  int quantity;
  Produto(this.id, this.product, this.price, this.quantity);
  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
        json["id"], json["product"], json["price"], json["quantity"]);
  }
}

// Classe produto_n para armazenar a lista total de products
class Produto_n {
  List prod = [];
  Produto_n(this.prod);
}
