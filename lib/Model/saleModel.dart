//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class Sale {
  final String id;
  final String idFerret;
  final String idClient;

  Sale(
    {
      required this.id, 
      required this.idFerret, 
      required this.idClient, 
    }
  );

  factory Sale.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Sale(
      id: snapshot.id,
      idFerret: data['idFerret'] ?? '',
      idClient: data['idClient'] ?? '',
    );
  }
}

Sale saleFromDocumentSnapshot(DocumentSnapshot snapshot) {
  final data = snapshot.data() as Map<String, dynamic>;
  return Sale(
      id: snapshot.id,
      idFerret: data['idFerret'],
      idClient: data['idClient'],
    );
}