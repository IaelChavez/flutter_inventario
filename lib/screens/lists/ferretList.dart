import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:practica_inventario/Model/models.dart';
import 'package:practica_inventario/firebase/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practica_inventario/Model/clienteModel.dart';
import 'package:practica_inventario/screens/screens.dart';
import 'package:practica_inventario/widgets/listStatic.dart';
import 'package:practica_inventario/widgets/widgets.dart';

import '../../firebase/firebase_ferret.dart';

class FerretList extends StatelessWidget {
  const FerretList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Ferrets ',
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => FerretView()));
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Ferret>>(
        future: getFerrets(),
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
            List<Ferret> ferret = snapshot.data!;
            return Lista(
              items: ferret,
              leadingIcon: Icons.person,
              base: 'ferrets',
              itemBuilder: (ferret) => Text(ferret.species),
              idItem: (ferret) => ferret.id,
              builderFromSnapshot: ferretFromDocumentSnapshot,
              updatePoint: FerretViewFactory,
              );
          }
        },
      ),
    );
  }
}
