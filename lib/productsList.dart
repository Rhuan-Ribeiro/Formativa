import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // biblioteca para requisições http.get
import 'dart:convert'; // biblioteca para conversao de json
import 'package:formativa/main.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  late Future<List<Product>> futureProduct;
  @override // late controla o estado futuro dos dados a partir da api
  void initState() {
    // TODO: implement initState
    super.initState();
    futureProduct =
        queryProduct(); // variavel para armazenar os dados vindos da api
  }

  // Função do tipo Future que vai receber atualização de dados a partir da api
  Future<List<Product>> queryProduct() async {
    final response =
        await http.get(Uri.parse('http://10.109.83.13:3000/products'));
    // print("responde: ${response.body}");

    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body) as List;
      //print(parsed); // realiza o parse do json da api
      print("parsed: $parsed");
      List<dynamic> productJson = parsed;

      return productJson.map((json) => Product.fromJson(json)).toList();
    } else {
      print(response.statusCode);
      throw Exception("Falha ao consumir api");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Produtos"),
          backgroundColor: Colors.blueAccent,
        ),
        body: Center(
          child: FutureBuilder<List<Product>>(
            future: futureProduct,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ProductListItem(product: snapshot.data![index]);
                    });
              } else if (snapshot.hasError) {
                //print("snapshot");
                return Text("${snapshot}");
              }
              return CircularProgressIndicator();
            },
          ),
        ));
  }
}

class Product {
  // Variaveis para consumir os dados da api
  final String id;
  final String product;
  final double price;
  final int quantity;
  final String imageurl;

  // Criar construtor
  Product(
      {required this.id,
      required this.product,
      required this.price,
      required this.quantity,
      required this.imageurl});

  // funçao para separar os dados da api em cada campo da classe
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      product: json['product'],
      price: json['price'],
      quantity: json['quantity'],
      imageurl: json['imageurl'],
    );
  }
}

class ProductListItem extends StatelessWidget {
  final Product product; //variavel do tipo product
  // construtor da classe product
  const ProductListItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ListTile lista de elementos
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageurl),
      ),
      title: Text(product.product),
      subtitle: Text("R\$${product.price}\nQuantidade:${product.quantity}"),
      // on tap transforma qualquer parte do app em botao
    );
  }
}
