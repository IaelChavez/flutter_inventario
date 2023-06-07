//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class Sale {
  final String id;
  final String idFerret;
  final String idClient;
  final String pieces;
  final String total;

  Sale(
    {
      required this.id, 
      required this.idFerret, 
      required this.idClient, 
      required this.pieces, 
      required this.total, 
    }
  );

  factory Sale.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Sale(
      id: snapshot.id,
      idFerret: data['idFerret'] ?? '',
      idClient: data['idClient'] ?? '',
      pieces: data['pieces'] ?? '',
      total: data['total'] ?? '',
    );
  }
}

Sale saleFromDocumentSnapshot(DocumentSnapshot snapshot) {
  final data = snapshot.data() as Map<String, dynamic>;
  return Sale(
      id: snapshot.id,
      idFerret: data['idFerret'],
      idClient: data['idClient'],
      pieces: data['pieces'],
      total: data['total'],
    );
}