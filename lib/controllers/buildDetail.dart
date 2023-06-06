import 'package:flutter/material.dart';
import 'package:practica_inventario/Model/models.dart';
import 'package:practica_inventario/controllers/controllers.dart';


String url(Object item, String base) {
  if (base == 'cliente') {
    DataItem<dynamic> data = item as DataItem<dynamic>;
    Cliente user = data.item;
    String imageValue = user.image;
    return imageValue;
  } else if (base == 'ferrets') {
    DataItem<dynamic> data = item as DataItem<dynamic>;
    Ferret ferret = data.item;
    String imageValue = ferret.image;
    return imageValue;
  } else if (base == 'sales') {
    DataItem<dynamic> data = item as DataItem<dynamic>;
    Sale sale = data.item;
    //  String imageValue = sale.image;
    //  return imageValue;
  } else if (base == 'supplier') {
    DataItem<dynamic> data = item as DataItem<dynamic>;
    Supplier supplier = data.item;
    String imageValue = supplier.image;
    return imageValue;
  }
  return 'Object type not supported';
}

Widget buildObjectDetails(Object object, String base) {
  if (base == 'users') {
    DataItem<dynamic> data = object as DataItem<dynamic>;
    Cliente user = data.item;
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
  } else if (base == 'ferrets') {
    DataItem<dynamic> data = object as DataItem<dynamic>;
    Ferret ferret = data.item;
    return Column(
      children: [
        buildDetailRow('Cost:', ferret.species),
        SizedBox(height: 8),
        buildDetailRow('Description:', ferret.age),
        SizedBox(height: 8),
        buildDetailRow('Name:', ferret.color),
        SizedBox(height: 8),
        buildDetailRow('Price:', ferret.price),
        SizedBox(height: 8),
        buildDetailRow('Units:', ferret.nationality),
        SizedBox(height: 8),
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
  } else if (base == 'suppliers') {
    DataItem<dynamic> data = object as DataItem<dynamic>;
    Supplier supplier = data.item;
    return Column(
      children: [
        buildDetailRow('Nombre:', supplier.name),
        SizedBox(height: 8),
        buildDetailRow('Apellido:', supplier.lastName),
        SizedBox(height: 8),
        buildDetailRow('Correo:', supplier.email),
        SizedBox(height: 8),
        buildDetailRow('Compañia:', supplier.company),
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
