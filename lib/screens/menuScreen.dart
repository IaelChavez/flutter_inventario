import 'package:flutter/material.dart';
import 'package:practica_inventario/screens/screens.dart';

import '../widgets/appbar.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Menu'),
          backgroundColor: Color.fromRGBO(16,44,68, 1),
        ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Card(
              child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MenuRegistrosScreen()));
            },
            child: const ListTile(
              leading: Icon(
                Icons.app_registration_outlined,
                size: 30,
                color: Colors.black,
              ),
              title: Text("Register", style: TextStyle(fontSize: 20.0)),
            ),
          )),
          Card(
              child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SaleList()));
            },
            child: const ListTile(
              leading: Icon(
                Icons.sell,
                size: 30,
                color: Colors.deepPurple,
              ),
              title: Text("Sales", style: TextStyle(fontSize: 20.0)),
            ),
          )),
          Card(
              child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PurchaseList()));
            },
            child: const ListTile(
              leading: Icon(
                Icons.shopping_bag,
                size: 30,
                color: Colors.red,
              ),
              title: Text("Purchase", style: TextStyle(fontSize: 20.0)),
            ),
          )),
        ],
      )),
                  backgroundColor: Color.fromRGBO(161,32,67,0.822),
    );
  }
}
