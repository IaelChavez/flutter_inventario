import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/UserModel.dart';
import 'firebase_services.dart';

Future<void> addUser(Map<String, dynamic> data) async {
  await db.collection('users').add(data);
}

Future<List<User>>? getUsers() async {
  List<User> users = [];
  QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('users').get();

  querySnapshot.docs.forEach((doc) {
    User user = User(
      id: doc.id,
      name: doc.data()['name'],
      lastName: doc.data()['lastName'],
      age: doc.data()['age'],
      gender: doc.data()['gender'],
      email: doc.data()['email'],
      password: doc.data()['password'],
    );
    users.add(user);
  });
  return users;
}