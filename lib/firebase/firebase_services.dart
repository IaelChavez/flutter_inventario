import 'package:cloud_firestore/cloud_firestore.dart';

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