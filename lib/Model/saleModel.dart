//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class Sale {
  final String id;
  final String idA;
  final String idProduct;
  final String name;
  final String pieces;

  Sale(
    {
      required this.id, 
      required this.idA, 
      required this.idProduct, 
      required this.name, 
      required this.pieces, 
    }
  );

  factory Sale.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Sale(
      id: snapshot.id,
      idA: data['IdA'] ?? '',
      idProduct: data['idProduct'] ?? '',
      name: data['name'] ?? '',
      pieces: data['pieces'] ?? '',
    );
  }
}

Sale saleFromDocumentSnapshot(DocumentSnapshot snapshot) {
  final data = snapshot.data() as Map<String, dynamic>;
  return Sale(
      id: snapshot.id,
      idA: data['IdA'],
      idProduct: data['idProduct'],
      name: data['name'],
      pieces: data['pieces'],
    );
}