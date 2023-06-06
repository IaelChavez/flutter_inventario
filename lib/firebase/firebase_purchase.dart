import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/purchaseModel.dart';
import 'firebase_services.dart';


Future<void> addPurchase(Map<String, dynamic> data) async {
  await db.collection('purchases').add(data);
}

Future<void> updatePurchase(Map<String, dynamic> data, documentId) async {
  await db.collection('purchases').doc(documentId).update(data);
}

Future<List<Purchase>> getPurchases() async {
  List<Purchase> purchases = [];
  QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('purchases').get();

  querySnapshot.docs.forEach((doc) {
    Purchase purchase = Purchase(
      id: doc.id,
      cant: doc.data()['cant'],
      idC: doc.data()['idC'],
      idProduct: doc.data()['idProduct'],
      idV: doc.data()['idV'],
      name: doc.data()['name'],
      pieces: doc.data()['pieces'],
      subtotal: doc.data()['subtotal'],
      total: doc.data()['total'],
    );
    purchases.add(purchase);
  });
  return purchases;
}