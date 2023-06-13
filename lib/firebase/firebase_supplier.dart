import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/supplierModel.dart';
import 'firebase_services.dart';

class Data {
  final String id;
  final String nombre;

  Data({required this.id, required this.nombre});
}

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

Future<List<Data>> getData() async {  
  QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('suppliers').get();

  List<Data> list = [];
  
  querySnapshot.docs.forEach((doc) {
    String id = doc.id;
    String nombre = doc.data()['company'];
    Data data = Data(id: id, nombre: nombre);
    list.add(data);
  });
  return list;
}