import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/saleModel.dart';
import 'firebase_services.dart';

Future<void> addSale(Map<String, dynamic> data) async {
  await db.collection('sales').add(data);
}

Future<List<Sale>> getSales() async {
  List<Sale> sales = [];
  QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('sales').get();

  querySnapshot.docs.forEach((doc) {
    Sale sale = Sale(
      id: doc.id,
      idA: doc.data()['IdA'],
      idProduct: doc.data()['idProduct'],
      name: doc.data()['name'],
      pieces: doc.data()['pieces'],
    );
    sales.add(sale);
  });
  return sales;
}