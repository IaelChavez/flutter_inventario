import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:practica_inventario/firebase/firebase_purchase.dart';
import 'package:practica_inventario/firebase/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practica_inventario/Model/userModel.dart';
import 'package:practica_inventario/screens/screens.dart';
import 'package:practica_inventario/widgets/listStatic.dart';
import 'package:practica_inventario/widgets/widgets.dart';

import '../../Model/purchaseModel.dart';

class PurchaseList extends StatelessWidget {
  const PurchaseList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Purchases ',
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => PurchaseScreen()));
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Purchase>>(
        future: getPurchases(),
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
            List<Purchase> purchase = snapshot.data!;
            return Lista(
              items: purchase,
              leadingIcon: Icons.person,
              base: 'purchases',
              itemBuilder: (purchase) => Text(purchase.name),
              idItem: (purchase) => purchase.id,
              builderFromSnapshot: purchaseFromDocumentSnapshot,
              updatePoint: UserViewFactory,
              );
          }
        },
      ),
    );
  }
}
