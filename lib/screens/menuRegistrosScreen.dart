import 'package:flutter/material.dart';
import 'package:practica_inventario/screens/screens.dart';

import '../widgets/appbar.dart';

class MenuRegistrosScreen extends StatelessWidget {
  const MenuRegistrosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Register ',
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Card(
              child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ClienteList()));
            },
            child: const ListTile(
              leading: Icon(
                Icons.person_add,
                size: 30,
              ),
              title: Text("Clientes", style: TextStyle(fontSize: 20.0)),
            ),
          )),
          Card(
              child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const FerretList()));
            },
            child: const ListTile(
              leading: Icon(
                Icons.add_to_photos_sharp,
                size: 30,
              ),
              title: Text("Hurones", style: TextStyle(fontSize: 20.0)),
            ),
          )),
        ],
      )),
    );
  }
}
