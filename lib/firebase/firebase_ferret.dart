import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/ferretModel.dart';
import 'firebase_services.dart';

Future<void> addFerret(Map<String, dynamic> data) async {
  await db.collection('ferrets').add(data);
}

Future<void> updateFerrets(Map<String, dynamic> data, documentId) async {
  await db.collection('ferrets').doc(documentId).update(data);
}

Future<List<Ferret>> getFerrets() async {
  List<Ferret> ferrets = [];
  QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('ferrets').get();

  querySnapshot.docs.forEach((doc) {
    Ferret ferret = Ferret(
      id: doc.id,
      species: doc.data()['species'],
      age: doc.data()['age'],
      color: doc.data()['color'],
      price: doc.data()['price'],
      nationality: doc.data()['nationality'],
      image: doc.data()['image'],
    );
    ferrets.add(ferret);
  });
  return ferrets;
}