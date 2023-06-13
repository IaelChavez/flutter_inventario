import 'package:flutter/material.dart';
import 'package:practica_inventario/Model/models.dart';
import 'package:practica_inventario/controllers/controllers.dart';
import 'package:practica_inventario/firebase/firebase_ferret.dart';


Future<String> geturl(Object item, String base) async {
    DataItem<dynamic> data = item as DataItem<dynamic>;
    Sale sale = data.item;
    Ferret ferret = await getFerret(sale.idFerret);
    return ferret.image;
}

Widget buildSalesDetails(Object object, String base) {
    DataItem<dynamic> data = object as DataItem<dynamic>;
    Sale sale = data.item;
    return Column(
      children: [
        buildDetailRow('idFerret:', sale.idFerret),
        SizedBox(height: 8),
        buildDetailRow('idClient:', sale.idClient),
      ],
    );
}

Widget buildDetailRow(String label, dynamic value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        value,
        style: const TextStyle(fontSize: 16),
      ),
      const SizedBox(height: 8),
    ],
  );
}
