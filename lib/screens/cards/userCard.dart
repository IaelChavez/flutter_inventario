import 'package:flutter/material.dart';
import 'package:practica_inventario/Model/UserModel.dart';
import 'package:practica_inventario/screens/screens.dart';

class CustomCard extends StatelessWidget {
  final Object item;

  CustomCard({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              color: Colors.blue,
              child: Icon(
                Icons.person,
                size: 100,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildObjectDetails(item)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}