import 'package:flutter/material.dart';
import 'package:practica_inventario/Model/models.dart';
import 'package:practica_inventario/controllers/controllers.dart';

Widget buildObjectDetails(Object object, String base) {
  if (base == 'users') {
    DataItem<dynamic> data = object as DataItem<dynamic>;
    User user= data.item;
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
    User user= data.item;
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
  }  else if (base == 'sales') {
    DataItem<dynamic> data = object as DataItem<dynamic>;
    User user= data.item;
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
  } else if (base == 'purchases') {
    DataItem<dynamic> data = object as DataItem<dynamic>;
    User user= data.item;
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
  }
  return Text('Object type not supported');
}




Widget buildDetailRow(String label, dynamic value) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 8),
      ],
    );
}
