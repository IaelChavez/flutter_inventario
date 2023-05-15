import 'package:flutter/material.dart';
import 'package:practica_inventario/Model/user.dart';
import 'package:practica_inventario/widgets/listStatic.dart';

class prueba extends StatelessWidget {
  final List<User> users = [
    User(nombre: 'John', precio: '2'),
    User(nombre: 'Johnaaaaa', precio: '2'),
    User(nombre: 'John', precio: '2'),
  ];

  prueba({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: UserList(
          user: users,
          leadingIcon: Icons.person,
          onEditPressed: () {
            // editar
          }, 
          onDeletePressed: () {
            // eliminar
          },
          onTap: () {
            // consultar
          }),
      ),
    );
  }
}