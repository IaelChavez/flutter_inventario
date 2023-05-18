import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:practica_inventario/firebase/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practica_inventario/Model/userModel.dart';
import 'package:practica_inventario/screens/screens.dart';
import 'package:practica_inventario/widgets/listStatic.dart';
import 'package:practica_inventario/widgets/widgets.dart';

class UsersList extends StatelessWidget {
  const UsersList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Users ',
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => userView()));
            },
          ),
        ],
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
            return Lista(
              items: users,
              leadingIcon: Icons.person,
              base: 'users',
              itemBuilder: (user) => Text('${user.name} ${user.lastName}'),
              idItem: (user) => user.id,
              builderFromSnapshot: userFromDocumentSnapshot,
            );
          }
        },
      ),
    );
  }
}
