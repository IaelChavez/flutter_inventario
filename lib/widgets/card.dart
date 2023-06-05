import 'package:flutter/material.dart';
import 'package:practica_inventario/Model/userModel.dart';
import 'package:practica_inventario/controllers/controllers.dart';

class CustomCard extends StatelessWidget {
  final Object item;
  final String base;

  CustomCard({required this.item, required this.base});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                alignment: Alignment.topCenter,
                height: MediaQuery.of(context).size.height / 1.7,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage("https://www.clinicaveterinariazarpa.com/wp-content/uploads/2019/04/ferret.jpg"), fit: BoxFit.cover)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.indigo[400],
                                borderRadius: BorderRadius.circular(30)),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                        )
                      ]),
                )),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [buildObjectDetails(item, base)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
