//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class Supplier {
  final String id;
  final String name;
  final String lastName;
  final String email;
  final String company;
  final String image;

  Supplier(
      {required this.id,
      required this.name,
      required this.lastName,
      required this.email,
      required this.company,
      required this.image,
  });

  factory Supplier.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Supplier(
      id: snapshot.id,
      name: data['name'] ?? '',
      lastName: data['lastName'] ?? '',
      email: data['email'] ?? '',
      company: data['company'] ?? '',
      image: data['image'] ?? '',
    );
  }
}

Supplier supplierFromDocumentSnapshot(DocumentSnapshot snapshot) {
  final data = snapshot.data() as Map<String, dynamic>;
  return Supplier(
    id: snapshot.id,
    name: data['name'],
    lastName: data['lastName'],
    email: data['email'],
    company: data['company'],
    image: data['image'],
  );
}
