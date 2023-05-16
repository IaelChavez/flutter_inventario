import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practica_inventario/Model/UserModel.dart';
import 'package:practica_inventario/widgets/widgets.dart';

class UserList extends StatelessWidget {
  final List<User> user;
  final IconData leadingIcon;

  UserList({required this.user, required this.leadingIcon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'App ',
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implementar funcionalidad de búsqueda
            },
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Implementar funcionalidad de menú
            },
          ),
        ],
      ),
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
                              _deleteUser(context, usuario.id);
                            },
                          ),
                        ]),
                        onTap: () {
                          // consultar
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

void _deleteUser(BuildContext context, String documentId) async {
  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(documentId)
        .delete();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Usuario eliminado correctamente')),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error al eliminar el usuario')),
    );
  }
}
