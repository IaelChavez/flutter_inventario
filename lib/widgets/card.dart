import 'package:flutter/material.dart';
import 'package:practica_inventario/Model/userModel.dart';
import 'package:practica_inventario/controllers/controllers.dart';

class CustomCard extends StatelessWidget {
  final Object item;
  final String base;

  CustomCard({
    required this.item,
    required this.base
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
                    buildObjectDetails(item, base)
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