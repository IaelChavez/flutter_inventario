import 'package:flutter/material.dart';
import 'package:practica_inventario/controllers/controllers.dart';

class saleCard extends StatelessWidget {
  final Object item;
  final String base;

  saleCard({required this.item, required this.base});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(192, 255, 255, 255),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<String>(
              future: geturl(item),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error al obtener la URL');
                } else {
                  String imageUrl = snapshot.data!;

                  return Container(
                    margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }
              }),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Cliente',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Container(
            color: Colors.blue[50],
            padding: EdgeInsets.all(8),
            alignment: Alignment.center,
            child: Text(
              'ID del Cliente',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          SizedBox(height: 15),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Ferret',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          FutureBuilder<Widget>(
              future: buildFerretDetail(item),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error al obtener el ferret');
                } else {
                  Widget dataFerret = snapshot.data!;
                  return dataFerret;
                }
              }),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Supplier',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          FutureBuilder<Widget>(
              future: buildSupplierDetail(item),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error al obtener el supplier');
                } else {
                  Widget dataSupplier = snapshot.data!;
                  return dataSupplier;
                }
              }),
        ],
      ),
    );
  }
}
