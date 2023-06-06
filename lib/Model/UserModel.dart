//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



abstract class ImageProperty {
  String get image;
}

class User extends ImageProperty {
  final String id;
  final String name;
  final String lastName;
  final String age;
  final String gender;
  final String email;
  final String password;
  
  @override
  final String image;

  User(
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

  factory User.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return User(
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

User userFromDocumentSnapshot(DocumentSnapshot snapshot) {
  final data = snapshot.data() as Map<String, dynamic>;
  return User(
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