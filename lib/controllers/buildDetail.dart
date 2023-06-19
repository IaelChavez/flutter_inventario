import 'package:flutter/material.dart';
import 'package:practica_inventario/Model/models.dart';
import 'package:practica_inventario/controllers/controllers.dart';
import 'package:practica_inventario/firebase/firebase_ferret.dart';

import '../firebase/firebase_supplier.dart';

String url(Object item, String base) {
  if (base == 'cliente') {
    DataItem<dynamic> data = item as DataItem<dynamic>;
    Cliente cliente = data.item;
    String imageValue = cliente.image;
    return imageValue;
  } else if (base == 'ferrets') {
    DataItem<dynamic> data = item as DataItem<dynamic>;
    Ferret ferret = data.item;
    String imageValue = ferret.image;
    return imageValue;
  } else if (base == 'supplier') {
    DataItem<dynamic> data = item as DataItem<dynamic>;
    Supplier supplier = data.item;
    String imageValue = supplier.image;
    return imageValue;
  }
  return 'Object type not supported';
}

Widget buildObjectDetails(Object object, String base) {
  if (base == 'clientes') {
    DataItem<dynamic> data = object as DataItem<dynamic>;
    Cliente cliente = data.item;
    return Column(
      children: [
        buildDetailRow('Name:', cliente.name),
        SizedBox(height: 8),
        buildDetailRow('Last Name:', cliente.lastName),
        SizedBox(height: 8),
        buildDetailRow('Age:', cliente.age),
        SizedBox(height: 8),
        buildDetailRow('Gender:', cliente.gender),
        SizedBox(height: 8),
        buildDetailRow('Email:', cliente.email),
        SizedBox(height: 8),
        buildDetailRow('Password:', cliente.password),
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

String getId(Object item)  {
  DataItem<dynamic> data = item as DataItem<dynamic>;
  Sale sale = data.item;
  return sale.id;
}

Future<String> geturl(Object item) async {
  DataItem<dynamic> data = item as DataItem<dynamic>;
  Sale sale = data.item;
  Ferret ferret = await getFerret(sale.idFerret);
  return ferret.image;
}

Widget buildTitle(String title) {
  return Text(
    title,
    style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.blue[800],
    ),
  );
}

Widget buildValue(dynamic value) {
  return Text(
    value,
    style: TextStyle(
      fontSize: 16,
      color: Colors.grey[700],
    ),
  );
}

Future<Widget> buildFerretDetail(Object object) async {
  DataItem<dynamic> data = object as DataItem<dynamic>;
  Sale sale = data.item;
  Ferret ferret = await getFerret(sale.idFerret);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildTitle('Especie'),
          buildTitle(''),
          buildTitle('Parametro 3'),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildValue('Valor 1'),
          buildValue('Valor 2'),
          buildValue('Valor 3'),
        ],
      ),
      SizedBox(height: 25),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildTitle('Parametro 4'),
          buildTitle('Parametro 5'),
          buildTitle('Parametro 6'),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildValue('Valor 4'),
          buildValue('Valor 5'),
          buildValue('Valor 6'),
        ],
      ),
      SizedBox(height: 15),
    ],
  );
}

Future<Widget> buildSupplierDetail(Object object) async {
  DataItem<dynamic> data = object as DataItem<dynamic>;
  Sale sale = data.item;
  Ferret ferret = await getFerret(sale.idFerret);
  Supplier supplier = await getSupplier(ferret.idSupplier);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildTitle('Parametro 1'),
          buildTitle('Parametro 2'),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildValue('Valor 1'),
          buildValue('Valor 2'),
        ],
      ),
      SizedBox(height: 25),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildTitle('Parametro 3'),
          buildTitle('Parametro 4'),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildValue('Valor 3'),
          buildValue('Valor 4'),
        ],
      ),
      SizedBox(height: 15),
    ],
  );
}
