import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practica_inventario/Model/user.dart';

class ListaProductos extends StatelessWidget {
  const ListaProductos({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('productos').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error al obtener los datos');
        }

        if (!snapshot.hasData) {
          return const Text('No hay datos disponibles');
        }

        final List<User> productos = snapshot.data!.docs.map((doc) {
          final nombre = doc['nombre'] as String;
          final precio = doc['precio'] as String;
          return User(nombre: nombre, precio: precio);
        }).toList();

        return ListView.builder(
          itemCount: productos.length,
          itemBuilder: (context, index) {
            final producto = productos[index];
            return ListTile(
              title: Text(producto.nombre),
              subtitle: Text(producto.precio),
            );
          },
        );
      },
    );
  }
}