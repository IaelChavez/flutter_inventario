// ignore_for_file: prefer_typing_uninitialized_variables

//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practica_inventario/Model/userModel.dart';
import 'package:practica_inventario/screens/screens.dart';
import 'package:practica_inventario/widgets/widgets.dart';

import 'package:practica_inventario/widgets/detail.dart';

class Lista<T> extends StatelessWidget {
  final List<T> items;
  final IconData leadingIcon;
  final String base;
  final Widget Function(T) itemBuilder;
  final String Function(T) idItem;
  final builderFromSnapshot;
  final Widget Function(String, String) updatePoint;

  Lista(
      {required this.items,
      required this.leadingIcon,
      required this.base,
      required this.itemBuilder,
      required this.idItem,
      required this.builderFromSnapshot,
      required this.updatePoint});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.indigo[400],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return SizedBox(
                      height: 80, // Alto deseado del Card
                      child: Card(
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
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
                                  if (updatePoint != null) {
                                    Widget instance =
                                        updatePoint(idItem(item), base);

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => instance),
                                    );
                                  }
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
                                  builder: (context) => UserDetail(
                                      documentId: idItem(item),
                                      base: base,
                                      builderFromSnapshot: builderFromSnapshot),
                                ),
                              );
                            }),
                      ),
                    );
                  },
                ),
              )
            ],
          )),
    );
  }
}

void _deleteUser(BuildContext context, String documentId, String base) async {
  try {
    await FirebaseFirestore.instance.collection(base).doc(documentId).delete();
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
    await FirebaseFirestore.instance.collection(base).doc(documentId).delete();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Eliminado correctamente')),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Error al eliminar')),
    );
  }
}
