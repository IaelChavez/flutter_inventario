import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/saleModel.dart';
import 'firebase_services.dart';

Future<void> addSale(Map<String, dynamic> data) async {
  await db.collection('sales').add(data);
}

Future<void> updateSales(Map<String, dynamic> data, documentId) async {
  await db.collection('sales').doc(documentId).update(data);
}

Future<List<Sale>> getSales() async {
  List<Sale> sales = [];
  QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('sales').get();

  querySnapshot.docs.forEach((doc) {
    Sale sale = Sale(
      id: doc.id,
      idFerret: doc.data()['idFerret'],
      idClient: doc.data()['idClient'],
      pieces: doc.data()['pieces'],
      total: doc.data()['total'],
    );
    sales.add(sale);
  });
  return sales;
}