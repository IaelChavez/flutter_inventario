import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/clienteModel.dart';
import 'firebase_services.dart';

Future<void> updatedCliente(Map<String, dynamic> data, documentId) async {
  await db.collection('clientes').doc(documentId).update(data);
}

Future<List<Cliente>>? getCliente() async {
  List<Cliente> clientes = [];
  QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('clientes').get();

  querySnapshot.docs.forEach((doc) {
    Cliente cliente = Cliente(
      id: doc.id,
      name: doc.data()['name'],
      lastName: doc.data()['lastName'],
      age: doc.data()['age'],
      gender: doc.data()['gender'],
      email: doc.data()['email'],
      password: doc.data()['password'],
      image: doc.data()['image']
    );
    clientes.add(cliente);
  });
  return clientes;
}