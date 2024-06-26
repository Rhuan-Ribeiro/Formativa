import 'package:flutter/material.dart'; // Pacote para o sistema operacional android
import 'package:formativa/cadasterProducts.dart';
import 'package:formativa/productsList.dart';

// Classe do tipo stateful
class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({super.key});

  @override
  // Variavel state que monitora os widgets da classe
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  int selectIndex = 0;
  // TextStyle tipo de variavel para receber parametros de acordo com o tipo da fonte do texto
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  // Cria uma lista de widgets para utilizar no navigator bar
  static const List<Widget> _widgetOptions = <Widget>[
    Products(),
    CadasterProducts(),
  ];
  void showItemTrap(int index) {
    setState(() {
      selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(selectIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: 'Produtos',
              backgroundColor: Colors.blueAccent,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.app_registration),
              label: 'Cadastro',
              backgroundColor: Colors.blueAccent,
            ),
          ],
          currentIndex: selectIndex,
          selectedItemColor: Colors.blueAccent,
          onTap: showItemTrap,
        ));
  }
}
