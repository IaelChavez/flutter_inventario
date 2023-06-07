import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:practica_inventario/firebase/firebase_supplier.dart';
import 'package:practica_inventario/firebase/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practica_inventario/Model/models.dart';
import 'package:practica_inventario/screens/screens.dart';
import 'package:practica_inventario/widgets/listStatic.dart';
import 'package:practica_inventario/widgets/widgets.dart';

import '../../Model/supplierModel.dart';

class SupplierList extends StatelessWidget {
  const SupplierList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Suppliers',
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SupplierScreen()));
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Supplier>>(
        future: getSuupplier(),
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
            List<Supplier> supplier = snapshot.data!;
            return Lista(
              items: supplier,
              leadingIcon: Icons.person,
              base: 'suppliers',
              itemBuilder: (supplier) => Text(supplier.name),
              idItem: (supplier) => supplier.id,
              builderFromSnapshot: supplierFromDocumentSnapshot,
              updatePoint: SupplierViewFactory,
              );
          }
        },
      ),
    );
  }
}
