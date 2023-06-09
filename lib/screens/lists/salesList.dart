import 'package:flutter/material.dart';
import 'package:practica_inventario/screens/screens.dart';
import 'package:practica_inventario/widgets/widgets.dart';

import '../../Model/saleModel.dart';
import '../../firebase/firebase_sales.dart';

class SaleList extends StatelessWidget {
  const SaleList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Sales ',
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SalesScreen()));
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Sale>>(
        future: getSales(),
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
            List<Sale> sales = snapshot.data!;
            return Lista(
              items: sales,
              leadingIcon: Icons.person,
              base: 'sales',
              itemBuilder: (sale) => Text(sale.id),
              idItem: (sale) => sale.id,
              builderFromSnapshot: saleFromDocumentSnapshot,
              updatePoint: SalesViewFactory,
              );
          }
        },
      ),
    );
  }
}
