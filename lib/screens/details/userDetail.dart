import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:practica_inventario/screens/cards/userCard.dart';
import 'package:practica_inventario/screens/lists/lists.dart';
import 'package:practica_inventario/widgets/widgets.dart';
import 'package:practica_inventario/firebase/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Model/UserModel.dart';

class UserDetail extends StatefulWidget {
  final String documentId;
  final String base;
  final builderFromSnapshot;

  UserDetail({required this.documentId, required this.base, required this.builderFromSnapshot});

  @override
  _UserDetail createState() => _UserDetail();
}

class _UserDetail extends State<UserDetail> {
  late Object item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'App ',
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>?>(
        future: getDataFirebase(widget.documentId, widget.base),
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
            if (snapshot.hasData) {
              DocumentSnapshot<Map<String, dynamic>> documentSnapshot = snapshot.data!;

              item = DataItem(
              snapshot: documentSnapshot, 
              fromDocumentSnapshot: widget.builderFromSnapshot
              );
            } else {
            }
            return Container(
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
                      margin: const EdgeInsets.symmetric(
                          vertical: 50.0, horizontal: 20.0),
                      padding: const EdgeInsets.all(20.0),
                      child: CustomCard(
                        item: item,
                      ),
                    ),
                  
                ));
          }
        },
      ),
    );
  }
}
