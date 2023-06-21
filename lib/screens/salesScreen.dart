import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../firebase/auth.dart';
import '../firebase/firebase_sales.dart';
import '../widgets/appbar.dart';
import 'lists/lists.dart';

class SalesScreen extends StatefulWidget {
  final String? documentId;
  final String? base;

  SalesScreen({super.key, this.documentId, this.base});

  @override
  _SalesScreen createState() => _SalesScreen();
}

Widget SalesViewFactory(String id, String base) {
  return SalesScreen(documentId: id, base: base);
}

class _SalesScreen extends State<SalesScreen> {

  _SalesScreen({Key? key}) : super();

  String _idFerret = '';
  String _idClient = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Sale ',
      ),
      body: widget.documentId == null
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/fondo.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(children: [
                Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    margin: const EdgeInsets.symmetric(
                        vertical: 50.0, horizontal: 20.0),
                    padding: const EdgeInsets.all(20.0),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('ferrets')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<QueryDocumentSnapshot> documents =
                              snapshot.data!.docs;
                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing:
                                  10.0, 
                              crossAxisSpacing:
                                  10.0, 
                            ),
                            itemCount: documents.length,
                            itemBuilder: (context, index) {
                              var data = documents[index].data()
                                  as Map<String, dynamic>;
                              String image = data['image'] ?? '';
                              String documentId = documents[index].id;

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _idFerret = documentId;
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: _idFerret == documentId
                                          ? Colors.blue
                                          : Colors.transparent,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Image.network(
                                    image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error al obtener los datos de Firebase');
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 40.0,
                  right: 20.0,
                  child: FloatingActionButton(
                    onPressed: () {
                      // Acción del botón flotante
                      try {
                        addSale({
                          'idFerret': _idFerret,
                          'idClient': 'fijo',
                        });

                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SaleList()));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Venta agregada correctamente')),
                        );
                      } catch (e) {}
                    },
                    child: Icon(Icons.add),
                  ),
                ),
              ]),
            )
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/fondo.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(children: [
                Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    margin: const EdgeInsets.symmetric(
                        vertical: 50.0, horizontal: 20.0),
                    padding: const EdgeInsets.all(20.0),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('ferrets')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<QueryDocumentSnapshot> documents =
                              snapshot.data!.docs;
                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing:
                                  10.0, 
                              crossAxisSpacing:
                                  10.0, 
                            ),
                            itemCount: documents.length,
                            itemBuilder: (context, index) {
                              var data = documents[index].data()
                                  as Map<String, dynamic>;
                              String image = data['image'] ?? '';
                              String documentId = documents[index].id;

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _idFerret = documentId;
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: _idFerret == documentId
                                          ? Colors.blue
                                          : Colors.transparent,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Image.network(
                                    image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error al obtener los datos de Firebase');
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 40.0,
                  right: 20.0,
                  child: FloatingActionButton(
                    onPressed: () {
                      // Acción del botón flotante
                      try {
                        updateSales({
                          'idFerret': _idFerret,
                          'idClient': Auth().currentUser!.uid  ,
                        },widget.documentId!);

                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SaleList()));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Venta agregada correctamente')),
                        );
                      } catch (e) {}
                    },
                    child: Icon(Icons.add),
                  ),
                ),
              ]),
            )
    );
  }
}
