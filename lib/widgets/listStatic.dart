import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practica_inventario/Model/userModel.dart';
import 'package:practica_inventario/widgets/widgets.dart';

import 'package:practica_inventario/widgets/detail.dart';

class Lista<T> extends StatelessWidget {
  final List<T> items;
  final IconData leadingIcon;
  final String base;
  final Widget Function(T) itemBuilder;
  final String Function(T) idItem;
  final builderFromSnapshot;

  Lista({required this.items, required this.leadingIcon, required this.base, required this.itemBuilder, required this.idItem, required this.builderFromSnapshot});

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
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
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
                        title: itemBuilder(item),
                        trailing:
                            Row(mainAxisSize: MainAxisSize.min, children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              _updateUser(context, idItem(item), base);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _deleteUser(context, idItem(item), base);
                            },
                          ),
                        ]),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserDetail(documentId: idItem(item), base: base, builderFromSnapshot: builderFromSnapshot,),
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
      const SnackBar(content: Text('Eliminado correctamente')),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Error al eliminar')),
    );
  }
}

void _updateUser(BuildContext context, String documentId, String base) async {
  try {
    await FirebaseFirestore.instance
        .collection(base)
        .doc(documentId)
        .delete();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Eliminado correctamente')),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Error al eliminar')),
    );
  }
}
