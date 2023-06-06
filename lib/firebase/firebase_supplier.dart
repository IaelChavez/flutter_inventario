import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/supplierModel.dart';
import 'firebase_services.dart';


Future<void> addSupplier(Map<String, dynamic> data) async {
  await db.collection('suppliers').add(data);
}

Future<void> updateSupplier(Map<String, dynamic> data, documentId) async {
  await db.collection('suppliers').doc(documentId).update(data);
}

Future<List<Supplier>> getSuupplier() async {
  List<Supplier> suppliers = [];
  QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('suppliers').get();

  querySnapshot.docs.forEach((doc) {
    Supplier supplier = Supplier(
      id: doc.id,
      name: doc.data()['name'],
      lastName: doc.data()['lastName'],
      email: doc.data()['email'],
      company: doc.data()['company'],
      image: doc.data()['image'],
    );
    suppliers.add(supplier);
  });
  return suppliers;
}