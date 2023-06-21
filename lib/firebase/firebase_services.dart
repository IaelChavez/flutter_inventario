//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/clienteModel.dart';

FirebaseFirestore db = FirebaseFirestore.instance;


Future<void> addOneCliente(Map<String, dynamic> data, String documentId) async {
  await db.collection("your_collection").doc(documentId).set(data);
}

Future<List<Cliente>>? getClientes() async {
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
      image: doc.data()['image'],
    );
    clientes.add(cliente);
  });
  return clientes;
}

Future<DocumentSnapshot<Map<String, dynamic>>?>getDataFirebase(String documentId, String base) async {
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection(base)
        .doc(documentId)
        .get();

    if (snapshot.exists) {
      return snapshot;
    } else {
      print('Documento no encontrado');
      return null;
    }
  } catch (e) {
    print('Error al recuperar datos: $e');
    return null;
  }
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