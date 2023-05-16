import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/UserModel.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<void> addProduct(Map<String, dynamic> data) async {
  await db.collection('products').add(data);
}

Future<void> addUser(Map<String, dynamic> data) async {
  await db.collection('users').add(data);
}

Future<void> addSale(Map<String, dynamic> data) async {
  await db.collection('sales').add(data);
}

Future<void> addPurchase(Map<String, dynamic> data) async {
  await db.collection('purchases').add(data);
}

Future<List<User>> getUsers() async {
  List<User> users = [];

  // Accede a la colección 'users' en Firestore
  QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('users').get();
  // Recorre los documentos y crea objetos User
  querySnapshot.docs.forEach((doc) {
    User user = User(
      id: doc.id,
      name: doc.data()['name'],
      lastName: doc.data()['lastName'],
      age: doc.data()['age'],
      gender: doc.data()['gender'],
      email: doc.data()['email'],
      password: doc.data()['password'],
    );
    users.add(user);
  });

  return users;
}

void deleteDocument(String documentId) async {
  try {
    await FirebaseFirestore.instance
        .collection('nombre_coleccion')
        .doc(documentId)
        .delete();
    print('Documento eliminado correctamente');
  } catch (e) {
    print('Error al eliminar el documento: $e');
  }
}