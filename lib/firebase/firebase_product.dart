import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/productModel.dart';
import 'firebase_services.dart';

Future<void> addProduct(Map<String, dynamic> data) async {
  await db.collection('products').add(data);
}

Future<List<Product>> getProducts() async {
  List<Product> purchases = [];
  QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('products').get();

  querySnapshot.docs.forEach((doc) {
    Product purchase = Product(
      id: doc.id,
      cost: doc.data()['cost'],
      description: doc.data()['description'],
      name: doc.data()['name'],
      price: doc.data()['price'],
      units: doc.data()['units'],
      utility: doc.data()['utility'],
    );
    purchases.add(purchase);
  });
  return purchases;
}