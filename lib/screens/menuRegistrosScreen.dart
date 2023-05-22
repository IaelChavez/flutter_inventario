import 'package:flutter/material.dart';
import 'package:practica_inventario/screens/screens.dart';

import '../widgets/appbar.dart';

class MenuRegistrosScreen extends StatelessWidget {
  const MenuRegistrosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
          backgroundColor: Color.fromRGBO(16,44,68, 1),
        ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Card(
              child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const UsersList()));
            },
            child: const ListTile(
              leading: Icon(
                Icons.person_add,
                size: 30,
                color: Colors.orange
              ),
              title: Text("Users", style: TextStyle(fontSize: 20.0)),
            ),
          )),
          Card(
              child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ProductList()));
            },
            child: const ListTile(
              leading: Icon(
                Icons.add_to_photos_sharp,
                size: 30,
                 color: Colors.blue
              ),
              title: Text("Products", style: TextStyle(fontSize: 20.0)),
            ),
          )),
        ],
      )),
      backgroundColor: Color.fromRGBO(161,32,67,0.822),
    );
  }
}
