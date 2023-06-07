//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Cliente {
  final String id;
  final String name;
  final String lastName;
  final String age;
  final String gender;
  final String email;
  final String password;
  final String image;

  Cliente(
    {
      required this.id, 
      required this.name, 
      required this.lastName, 
      required this.age, 
      required this.gender, 
      required this.email, 
      required this.password,
      required this.image,
    }
  );

  factory Cliente.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Cliente(
      id: snapshot.id,
      name: data['name'] ?? '',
      lastName: data['lastName'] ?? '',
      age: data['age'] ?? '',
      gender: data['gender'] ?? '',
      email: data['email'] ?? '',
      password: data['password'] ?? '',
      image: data['image'] ?? '',
    );
  }
}

Cliente clienteFromDocumentSnapshot(DocumentSnapshot snapshot) {
  final data = snapshot.data() as Map<String, dynamic>;
  return Cliente(
      id: snapshot.id,
      name: data['name'],
      lastName: data['lastName'],
      age: data['age'],
      gender: data['gender'],
      email: data['email'],
      password: data['password'] ,
      image: data['image']
    );
}