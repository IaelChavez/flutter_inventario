import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:practica_inventario/widgets/card.dart';
import 'package:practica_inventario/widgets/widgets.dart';
import 'package:practica_inventario/firebase/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practica_inventario/controllers/controllers.dart';

import '../Model/clienteModel.dart';

class ClienteDetail extends StatefulWidget {
  final String documentId;
  final String base;
  final builderFromSnapshot;

  ClienteDetail(
      {required this.documentId,
      required this.base,
      required this.builderFromSnapshot});

  @override
  _ClienteDetail createState() => _ClienteDetail();
}

class _ClienteDetail extends State<ClienteDetail> {
  late Object item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>?>(
        future: getDataFirebase(widget.documentId, widget.base),
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
            if (snapshot.hasData) {
              DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
                  snapshot.data!;

              item = DataItem(
                  snapshot: documentSnapshot,
                  fromDocumentSnapshot: widget.builderFromSnapshot);
            } else {}
            return Container(
              child: CustomCard(
                item: item,
                base: widget.base,
              ),
            );
          }
        },
      ),
    );
  }
}
