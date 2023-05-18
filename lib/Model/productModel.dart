import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String cost;
  final String description;
  final String name;
  final String price;
  final String units;
  final String utility;

  Product(
      {required this.id,
      required this.cost,
      required this.description,
      required this.name,
      required this.price,
      required this.units,
      required this.utility});

  factory Product.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Product(
      id: snapshot.id,
      cost: data['cost'] ?? '',
      description: data['description'] ?? '',
      name: data['name'] ?? '',
      price: data['price'] ?? '',
      units: data['units'] ?? '',
      utility: data['utility'] ?? '',
    );
  }
}

Product productFromDocumentSnapshot(DocumentSnapshot snapshot) {
  final data = snapshot.data() as Map<String, dynamic>;
  return Product(
    id: snapshot.id,
    cost: data['cost'],
    description: data['description'],
    name: data['name'],
    price: data['price'],
    units: data['units'],
    utility: data['utility'],
  );
}
