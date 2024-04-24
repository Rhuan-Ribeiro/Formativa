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
  var products = <Product>[];

  _get() async {
    http.Response response = await http.get(Uri.parse(url));

    data = json.decode(response.body);

    for (int i = 0; i < data.length; i++) {
      print("i: ${data[i]}");
    }
    print("products: $products");
    print("data: $data");
    setState(() {
      print("test");
      products = data.map((json) => Product.fromJson(json)).toList();
      print("products: $products");
    });
    // print(products);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Produtos"),
        ),
        body: Column(
          children: [
            Column(
                // exibe os dados no text
                // map faz o mapeamento dos dados na lista
                mainAxisAlignment: MainAxisAlignment.center,
                children: products
                    .map((product) => Text(
                          "${product.product}\nPreço: R\$ ${product.price}\nQuantidade: ${product.quantity}\n\n",
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ))
                    .toList()),
            ElevatedButton(onPressed: _get, child: Icon(Icons.abc))
          ],
        ));
  }
}

class Product {
  String id;
  String product;
  double price;
  int quantity;
  Product(this.id, this.product, this.price, this.quantity);
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        json["id"], json["product"], json["price"], json["quantity"]);
  }
}
