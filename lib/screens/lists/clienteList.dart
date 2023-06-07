import 'package:flutter/material.dart';
import 'package:practica_inventario/firebase/firebase_services.dart';
import 'package:practica_inventario/Model/clienteModel.dart';
import 'package:practica_inventario/screens/screens.dart';
import 'package:practica_inventario/widgets/widgets.dart';

class ClienteList extends StatelessWidget {
  const ClienteList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Cliente ',
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ClienteView(documentId: null,base: null)));
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Cliente>>(
        future: getClientes(),
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
            List<Cliente> clientes = snapshot.data!;
            return Lista(
              items: clientes,
              leadingIcon: Icons.person,
              base: 'clientes',
              itemBuilder: (cliente) => Text(cliente.name),
              idItem: (cliente) => cliente.id,
              builderFromSnapshot: clienteFromDocumentSnapshot,
              updatePoint: ClienteViewFactory,
            );
          }
        },
      ),
    );
  }
}

