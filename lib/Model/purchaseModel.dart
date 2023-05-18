//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class Purchase {
  final String id;
  final String cant;
  final String idC;
  final String idProduct;
  final String idV;
  final String name;
  final String pieces;
  final String subtotal;
  final String total;

  Purchase(
      {required this.id,
      required this.cant,
      required this.idC,
      required this.idProduct,
      required this.idV,
      required this.name,
      required this.pieces,
      required this.subtotal,
      required this.total});

  factory Purchase.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Purchase(
      id: snapshot.id,
      cant: data['cant'] ?? '',
      idC: data['idC'] ?? '',
      idProduct: data['idProduct'] ?? '',
      idV: data['idV'] ?? '',
      name: data['name'] ?? '',
      pieces: data['pieces'] ?? '',
      subtotal: data['subtotal'] ?? '',
      total: data['total'] ?? '',
    );
  }
}

Purchase purchaseFromDocumentSnapshot(DocumentSnapshot snapshot) {
  final data = snapshot.data() as Map<String, dynamic>;
  return Purchase(
    id: snapshot.id,
    cant: data['cant'],
    idC: data['idC'],
    idProduct: data['idProduct'],
    idV: data['idV'],
    name: data['name'],
    pieces: data['pieces'],
    subtotal: data['subtotal'],
    total: data['total'],
  );
}
