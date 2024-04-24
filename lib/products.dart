import 'package:flutter/material.dart'; // Pacote para o sistema operacional android
import 'package:formativa/cadasterProducts.dart';
import 'package:formativa/productsList.dart';

// Classe NavBottom do tipo stateless, pois não tem widgets dinamicos
class NavBottom extends StatelessWidget {
  const NavBottom({super.key}); // construtor

  @override
  Widget build(BuildContext context) {
    // Scaffold é o layout semipronto do aplicativo
    return MaterialApp(
        home: // app bar é a barra do aplicativo

            NavigatorScreen());
  }
}

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
    //Text('Index 0 : Home',style:optionStyle ),
    Products(),
    CadasterProducts(),
    // //Text('Index 1: Escola',style:optionStyle ),
    // //Text('Index 2: Negócio',style: optionStyle,),
    // rb(),
    // Text('Index 3: Configurações',style:optionStyle),
  ];
  // Funçao que muda o index conforme o icone é pressionado
  void showItemTrap(int index) {
    setState(() {
      selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Widget Scaffold
    return Scaffold(
        body: Center(
          // .elementAt permite passar um numero como index para o widget
          child: _widgetOptions.elementAt(selectIndex),
        ),
        // criar o bottom navigator

        bottomNavigationBar: BottomNavigationBar(
          // itens é cada item do navigation bar
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
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.business),
            //   label: 'Negócios',
            //   backgroundColor: Color.fromARGB(255, 61, 114, 141),
            // ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.settings),
            //   label: 'Settings',
            //   backgroundColor: Color.fromARGB(255, 48, 88, 107),
            // ),
          ],
          currentIndex: selectIndex,
          selectedItemColor: Colors.blueAccent,
          onTap: showItemTrap,
        ));
  }
}
