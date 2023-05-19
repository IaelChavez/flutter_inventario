import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practica_inventario/widgets/appbar.dart';
import 'package:practica_inventario/widgets/textField.dart';

import '../Model/models.dart';
import '../firebase/firebase_product.dart';
import '../firebase/firebase_services.dart';
import '../widgets/button.dart';

class ProductView extends StatefulWidget {
  String? documentId;
  String? base;

  ProductView({super.key, this.documentId, this.base});

  @override
  _ProductView createState() => _ProductView();
}

Widget ProductViewFactory(String id, String base) {
  return ProductView(documentId: id, base: base);
}

class _ProductView extends State<ProductView> {
  _ProductView({Key? key}) : super();

  final _formKey = GlobalKey<FormState>();

  final List<String> _errors = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController unitsController = TextEditingController();
  final TextEditingController costController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController utilityController = TextEditingController();

  bool _showErrorName = false;
  bool _showErrorDescription = false;
  bool _showErrorUnits = false;
  bool _showErrorCost = false;
  bool _showErrorPrice = false;
  bool _showErrorUtility = false;

  String _name = '';
  String _descrition = '';
  String _units = '';
  String _cost = '';
  String _price = '';
  String _utility = '';

  vaciarCampos() {
    nameController.clear();
    descriptionController.clear();
    unitsController.clear();
    costController.clear();
    priceController.clear();
    utilityController.clear();

    _name = '';
    _descrition = '';
    _units = '';
    _cost = '';
    _price = '';
    _utility = '';
  }

  bool _validar(String value) {
    if (value.isEmpty) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    nameController.addListener(() {
      _name = nameController.text;
    });
    descriptionController.addListener(() {
      _descrition = descriptionController.text;
    });
    unitsController.addListener(() {
      _units = unitsController.text;
    });
    costController.addListener(() {
      _cost = costController.text;
    });
    priceController.addListener(() {
      _price = priceController.text;
    });
    utilityController.addListener(() {
      _utility = utilityController.text;
    });

    return Scaffold(
        appBar: const CustomAppBar(
          title: 'Product ',
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
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: SingleChildScrollView(
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        margin: const EdgeInsets.symmetric(
                            vertical: 50.0, horizontal: 20.0),
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 20),
                                  CustomTextField(
                                    controller: nameController,
                                    label: 'nombre',
                                    keyboardType: TextInputType.text,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[a-zA-Z]'))
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _name = value;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  CustomTextField(
                                    controller: descriptionController,
                                    label: 'descripcion',
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[a-zA-Z]'))
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _descrition = value;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  CustomTextField(
                                    controller: unitsController,
                                    label: 'unidades',
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _cost = value;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  CustomTextField(
                                    controller: costController,
                                    label: 'costo',
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _cost = value;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  CustomTextField(
                                    controller: priceController,
                                    label: 'precio',
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _price = value;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  CustomTextField(
                                    controller: utilityController,
                                    label: 'utilidad',
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _utility = value;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: widget.documentId != null,
                              child: GradientButton(
                                onPressed: () {
                                  // Acción cuando se presione el botón
                                  updateProducts({
                                    'name': _name,
                                    'description': _descrition,
                                    'units': _units,
                                    'cost': _cost,
                                    'price': _price,
                                    'utility': _utility,
                                  }, widget.documentId!);
                                },
                                text: 'Actualizar',
                              ),
                            ),
                            Visibility(
                              visible: widget.documentId == null,
                              child: GradientButton(
                                text: 'Guardar',
                                onPressed: () {
                                  setState(() {
                                    _showErrorName = false;
                                    _showErrorDescription = false;
                                    _showErrorUnits = false;
                                    _showErrorCost = false;
                                    _showErrorPrice = false;
                                    _showErrorUtility = false;
                                    // Validar cada campo individualmente para mostrar la alerta una por una
                                    if (_validar(_name)) {
                                      _showErrorName = true;
                                    } else if (_validar(_descrition)) {
                                      _showErrorDescription = true;
                                    } else if (_validar(_units)) {
                                      _showErrorUnits = true;
                                    } else if (_validar(_cost)) {
                                      _showErrorCost = true;
                                    } else if (_validar(_price)) {
                                      _showErrorPrice = true;
                                    } else if (_validar(_utility)) {
                                      _showErrorUtility = true;
                                    } else {
                                      // El formulario es válido, envía los datos
                                      try {
                                        addProduct({
                                          'name': _name,
                                          'description': _descrition,
                                          'units': _units,
                                          'cost': _cost,
                                          'price': _price,
                                          'utility': _utility,
                                        });
                                        vaciarCampos();
                                      } catch (e) {}
                                    }
                                  });
                                },
                              ),
                            ),
                            const SizedBox(height: 15),
                            Visibility(
                              visible: _showErrorName,
                              child: const Text('Rellena el nombre.'),
                            ),
                            Visibility(
                              visible: _showErrorDescription,
                              child: const Text('Rellena la descripcion.'),
                            ),
                            Visibility(
                              visible: _showErrorUnits,
                              child: const Text('Rellena las unidades.'),
                            ),
                            Visibility(
                              visible: _showErrorCost,
                              child: const Text('Rellena el costo.'),
                            ),
                            Visibility(
                              visible: _showErrorPrice,
                              child: const Text('Rellena el precio.'),
                            ),
                            Visibility(
                              visible: _showErrorUtility,
                              child: const Text('Rellena la utilidad.'),
                            ),
                          ],
                        )),
                  ),
                ),
              )
            : FutureBuilder<DocumentSnapshot<Map<String, dynamic>>?>(
                future: getDataFirebase(widget.documentId!, widget.base!),
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
                    if (snapshot.hasData) {
                      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
                          snapshot.data!;

                      Product product =
                          Product.fromDocumentSnapshot(documentSnapshot);

                      nameController.text = product.name;
                      descriptionController.text = product.description;
                      unitsController.text = product.units;
                      costController.text = product.cost;
                      priceController.text = product.price;
                      utilityController.text = product.utility;
                    }
                    return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/fondo.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Scaffold(
                          backgroundColor: Colors.transparent,
                          body: SingleChildScrollView(
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 50.0, horizontal: 20.0),
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(height: 20),
                                          CustomTextField(
                                            controller: nameController,
                                            label: 'nombre',
                                            keyboardType: TextInputType.text,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter.allow(
                                                  RegExp('[a-zA-Z]'))
                                            ],
                                            onChanged: (value) {},
                                          ),
                                          const SizedBox(height: 20),
                                          CustomTextField(
                                            controller: descriptionController,
                                            label: 'descripcion',
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter.allow(
                                                  RegExp('[a-zA-Z]'))
                                            ],
                                            onChanged: (value) {},
                                          ),
                                          const SizedBox(height: 20),
                                          CustomTextField(
                                            controller: unitsController,
                                            label: 'unidades',
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            onChanged: (value) {
                                            },
                                          ),
                                          const SizedBox(height: 20),
                                          CustomTextField(
                                            controller: costController,
                                            label: 'costo',
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            onChanged: (value) {},
                                          ),
                                          const SizedBox(height: 20),
                                          CustomTextField(
                                            controller: priceController,
                                            label: 'precio',
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            onChanged: (value) {},
                                          ),
                                          const SizedBox(height: 20),
                                          CustomTextField(
                                            controller: utilityController,
                                            label: 'utilidad',
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            onChanged: (value) {},
                                          ),
                                          const SizedBox(height: 20),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible: widget.documentId != null,
                                      child: GradientButton(
                                        onPressed: () {
                                          // Acción cuando se presione el botón
                                          updateProducts({
                                            'name': _name,
                                            'description': _descrition,
                                            'units': _units,
                                            'cost': _cost,
                                            'price': _price,
                                            'utility': _utility,
                                          }, widget.documentId!);
                                        },
                                        text: 'Actualizar',
                                      ),
                                    ),
                                    Visibility(
                                      visible: widget.documentId == null,
                                      child: GradientButton(
                                        text: 'Guardar',
                                        onPressed: () {
                                          setState(() {
                                            _showErrorName = false;
                                            _showErrorDescription = false;
                                            _showErrorUnits = false;
                                            _showErrorCost = false;
                                            _showErrorPrice = false;
                                            _showErrorUtility = false;
                                            // Validar cada campo individualmente para mostrar la alerta una por una
                                            if (_validar(_name)) {
                                              _showErrorName = true;
                                            } else if (_validar(_descrition)) {
                                              _showErrorDescription = true;
                                            } else if (_validar(_units)) {
                                              _showErrorUnits = true;
                                            } else if (_validar(_cost)) {
                                              _showErrorCost = true;
                                            } else if (_validar(_price)) {
                                              _showErrorPrice = true;
                                            } else if (_validar(_utility)) {
                                              _showErrorUtility = true;
                                            } else {
                                              // El formulario es válido, envía los datos
                                              try {
                                                addProduct({
                                                  'name': _name,
                                                  'description': _descrition,
                                                  'units': _units,
                                                  'cost': _cost,
                                                  'price': _price,
                                                  'utility': _utility,
                                                });
                                                vaciarCampos();
                                              } catch (e) {}
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Visibility(
                                      visible: _showErrorName,
                                      child: const Text('Rellena el nombre.'),
                                    ),
                                    Visibility(
                                      visible: _showErrorDescription,
                                      child:
                                          const Text('Rellena la descripcion.'),
                                    ),
                                    Visibility(
                                      visible: _showErrorUnits,
                                      child:
                                          const Text('Rellena las unidades.'),
                                    ),
                                    Visibility(
                                      visible: _showErrorCost,
                                      child: const Text('Rellena el costo.'),
                                    ),
                                    Visibility(
                                      visible: _showErrorPrice,
                                      child: const Text('Rellena el precio.'),
                                    ),
                                    Visibility(
                                      visible: _showErrorUtility,
                                      child: const Text('Rellena la utilidad.'),
                                    ),
                                  ],
                                )),
                          ),
                        ));
                  }
                }));
  }
}
