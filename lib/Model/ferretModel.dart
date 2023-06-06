import 'package:cloud_firestore/cloud_firestore.dart';

class Ferret {
  final String id;
  final String species;
  final String age;
  final String color;
  final String price;
  final String nationality;
  final String image;

  Ferret({
    required this.id,
    required this.species,
    required this.age,
    required this.color,
    required this.price,
    required this.nationality,
    required this.image,
  });

  factory Ferret.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Ferret(
      id: snapshot.id,
      species: data['species'] ?? '',
      age: data['age'] ?? '',
      color: data['color'] ?? '',
      price: data['price'] ?? '',
      nationality: data['nationality'] ?? '',
      image: data['image'] ?? '',
    );
  }
}

Ferret ferretFromDocumentSnapshot(DocumentSnapshot snapshot) {
  final data = snapshot.data() as Map<String, dynamic>;
  return Ferret(
    id: snapshot.id,
    species: data['species'],
    age: data['age'],
    color: data['color'],
    price: data['price'],
    nationality: data['nationality'],
    image: data['image'],
  );
}
