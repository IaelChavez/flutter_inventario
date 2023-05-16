import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:practica_inventario/firebase/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practica_inventario/Model/UserModel.dart';
import 'package:practica_inventario/widgets/listStatic.dart';
import 'package:practica_inventario/widgets/widgets.dart';

class UsersList extends StatelessWidget {
  const UsersList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Users'),
      ),
      body: FutureBuilder<List<User>>(
        future: getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<User> users = snapshot.data!;
            return UserList(
              user: users,
              leadingIcon: Icons.person,
              );
          }
        },
      ),
    );
  }
}
