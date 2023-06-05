import 'package:flutter/material.dart';
import 'package:practica_inventario/Model/models.dart';
import 'package:practica_inventario/controllers/controllers.dart';

Widget buildObjectDetails(Object object, String base) {
  if (base == 'users') {
    DataItem<dynamic> data = object as DataItem<dynamic>;
    User user = data.item;
    return Column(
      children: [
        buildDetailRow('Name:', user.name),
        SizedBox(height: 8),
        buildDetailRow('Last Name:', user.lastName),
        SizedBox(height: 8),
        buildDetailRow('Age:', user.age),
        SizedBox(height: 8),
        buildDetailRow('Gender:', user.gender),
        SizedBox(height: 8),
        buildDetailRow('Email:', user.email),
        SizedBox(height: 8),
        buildDetailRow('Password:', user.password),
      ],
    );
  } else if (base == 'products') {
    DataItem<dynamic> data = object as DataItem<dynamic>;
    Product product = data.item;
    return Column(
      children: [
        buildDetailRow('Cost:', product.cost),
        SizedBox(height: 8),
        buildDetailRow('Description:', product.description),
        SizedBox(height: 8),
        buildDetailRow('Name:', product.name),
        SizedBox(height: 8),
        buildDetailRow('Price:', product.price),
        SizedBox(height: 8),
        buildDetailRow('Units:', product.units),
        SizedBox(height: 8),
        buildDetailRow('Utility:', product.utility),
      ],
    );
  } else if (base == 'sales') {
    DataItem<dynamic> data = object as DataItem<dynamic>;
    Sale sale = data.item;
    return Column(
      children: [
        buildDetailRow('IdA:', sale.idA),
        SizedBox(height: 8),
        buildDetailRow('IdProduct:', sale.idProduct),
        SizedBox(height: 8),
        buildDetailRow('Name:', sale.name),
        SizedBox(height: 8),
        buildDetailRow('Pieces:', sale.pieces),
      ],
    );
  } else if (base == 'purchases') {
    DataItem<dynamic> data = object as DataItem<dynamic>;
    Purchase purchase = data.item;
    return Column(
      children: [
        buildDetailRow('Cant:', purchase.cant),
        SizedBox(height: 8),
        buildDetailRow('IdC:', purchase.idC),
        SizedBox(height: 8),
        buildDetailRow('IdProduct:', purchase.idProduct),
        SizedBox(height: 8),
        buildDetailRow('IdV:', purchase.idV),
        SizedBox(height: 8),
        buildDetailRow('Name:', purchase.name),
        SizedBox(height: 8),
        buildDetailRow('Pieces:', purchase.pieces),
        SizedBox(height: 8),
        buildDetailRow('Subtotal:', purchase.subtotal),
        SizedBox(height: 8),
        buildDetailRow('Total:', purchase.total),
      ],
    );
  }
  return Text('Object type not supported');
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
