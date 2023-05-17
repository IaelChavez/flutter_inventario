import 'package:flutter/material.dart';
import 'package:practica_inventario/Model/models.dart';

Widget buildObjectDetails(Object object) {
  if (object is User) {

    User user = object as User;
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
  } else if (object is Object) {

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
