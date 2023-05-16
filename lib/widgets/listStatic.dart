import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practica_inventario/Model/UserModel.dart';
import 'package:practica_inventario/widgets/widgets.dart';

import '../screens/details/details.dart';

class UserList extends StatelessWidget {
  final List<User> user;
  final IconData leadingIcon;
  final String base;

  UserList({required this.user, required this.leadingIcon, required this.base});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fondo.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin:
                const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
            padding: const EdgeInsets.all(20.0),
            child: ListView.builder(
              itemCount: user.length,
              itemBuilder: (context, index) {
                final usuario = user[index];
                return Container(
                  height: 80, // Alto deseado del Card
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.white,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                        leading: CircleAvatar(
                          radius: 17,
                          backgroundColor: Colors.blue,
                          child: Icon(
                            leadingIcon,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(usuario.name),
                        subtitle: Text(usuario.lastName),
                        trailing:
                            Row(mainAxisSize: MainAxisSize.min, children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              // editar
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _deleteUser(context, usuario.id, base);
                            },
                          ),
                        ]),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserDetail(documentId: usuario.id, base: base),
                            ),
                          );
                        }),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

void _deleteUser(BuildContext context, String documentId, String base) async {
  try {
    await FirebaseFirestore.instance
        .collection(base)
        .doc(documentId)
        .delete();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Usuario eliminado correctamente')),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Error al eliminar el usuario')),
    );
  }
}
