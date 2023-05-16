import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:practica_inventario/screens/Cards/userCard.dart';
import 'package:practica_inventario/widgets/widgets.dart';
import 'package:practica_inventario/firebase/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Model/UserModel.dart';

class UserDetail extends StatefulWidget {
  final String documentId;
  final String base;

  UserDetail({required this.documentId, required this.base});

  @override
  _UserDetail createState() => _UserDetail();
}

class _UserDetail extends State<UserDetail> {
  User? userData;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    userData = await getDataFirebase(widget.documentId, widget.base);
    print(userData!.age);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'App ',
      ),
      body: FutureBuilder<User?>(
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
            User user = snapshot.data!;

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
                      child: UserCard(
                        user: user,
                      ),
                    ),
                  
                ));
          }
        },
      ),
    );
  }
}
