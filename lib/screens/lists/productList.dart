import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:practica_inventario/Model/models.dart';
import 'package:practica_inventario/firebase/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practica_inventario/Model/UserModel.dart';
import 'package:practica_inventario/screens/screens.dart';
import 'package:practica_inventario/widgets/listStatic.dart';
import 'package:practica_inventario/widgets/widgets.dart';

import '../../firebase/firebase_product.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Products ',
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ProductView()));
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<Product> products = snapshot.data!;
            return Lista(
              items: products,
              leadingIcon: Icons.person,
              base: 'products',
              itemBuilder: (product) => Text(product.name),
              idItem: (product) => product.id,
              builderFromSnapshot: productFromDocumentSnapshot,
              updatePoint: ProductViewFactory,
              );
          }
        },
      ),
    );
  }
}
