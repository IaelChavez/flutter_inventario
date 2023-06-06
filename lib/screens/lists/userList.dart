import 'package:flutter/material.dart';
import 'package:practica_inventario/firebase/firebase_services.dart';
import 'package:practica_inventario/Model/clienteModel.dart';
import 'package:practica_inventario/screens/screens.dart';
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
                  context, MaterialPageRoute(builder: (context) => userView(documentId: null,base: null)));
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Cliente>>(
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
            List<Cliente> users = snapshot.data!;
            return Lista(
              items: users,
              leadingIcon: Icons.person,
              base: 'users',
              itemBuilder: (user) => Text(user.name),
              idItem: (user) => user.id,
              builderFromSnapshot: userFromDocumentSnapshot,
              updatePoint: UserViewFactory,
            );
          }
        },
      ),
    );
  }
}

