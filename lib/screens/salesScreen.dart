import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practica_inventario/firebase/firebase_services.dart';

import '../widgets/appbar.dart';
import '../widgets/button.dart';
import '../widgets/textField.dart';

class SalesScreen extends StatefulWidget {
  @override
  _SalesScreen createState() => _SalesScreen();
}

class _SalesScreen extends State<SalesScreen> {
  _SalesScreen({Key? key}) : super();

  final _formKey = GlobalKey<FormState>();

  final List<String> _errors = [];

  final TextEditingController idProductController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController piecesController = TextEditingController();
  final TextEditingController idAController = TextEditingController();

  bool _showErrorIdProduct = false;
  bool _showErrorName = false;
  bool _showErrorPieces = false;
  bool _showErrorIdA = false;

  String _idProduct = '';
  String _name = '';
  String _pieces = '';
  String _idA = '';

  vaciarCampos() {
    idProductController.clear();
    nameController.clear();
    piecesController.clear();
    idAController.clear();

    _idProduct = '';
    _name = '';
    _pieces = '';
    _idA = '';
  }

  bool _validar(String value) {
    if (value.isEmpty) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'App ',
        ),
        body: Container(
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
                            CustomTextField(
                              controller: idProductController,
                              label: 'Id Producto',
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _idProduct = value;
                                });
                              },
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              controller: nameController,
                              label: 'Nombre',
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
                              controller: piecesController,
                              label: 'Piezas',
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _pieces = value;
                                });
                              },
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              controller: idAController,
                              label: 'IdA',
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _idA = value;
                                });
                              },
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                      GradientButton(
                        text: 'Guardar',
                        onPressed: () {
                          setState(() {
                            _showErrorIdProduct = false;
                            _showErrorName = false;
                            _showErrorPieces = false;
                            _showErrorIdA = false;
                            // Validar cada campo individualmente para mostrar la alerta una por una
                            if (_validar(_idProduct)) {
                              _showErrorIdProduct = true;
                            } else if (_validar(_name)) {
                              _showErrorName = true;
                            } else if (_validar(_pieces)) {
                              _showErrorPieces = true;
                            } else if (_validar(_idA)) {
                              _showErrorIdA = true;
                            } else {
                              // El formulario es válido, envía los datos
                              try {
                                addSale({
                                  'idProduct': _idProduct,
                                  'name': _name,
                                  'pieces': _pieces,
                                  'IdA': _idA,
                                });
                                vaciarCampos();
                              } catch (e) {}
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 15),
                      Visibility(
                        visible: _showErrorIdProduct,
                        child: const Text('Rellena el idProduct.'),
                      ),
                      Visibility(
                        visible: _showErrorName,
                        child: const Text('Rellena el nombre.'),
                      ),
                      Visibility(
                        visible: _showErrorPieces,
                        child: const Text('Rellena pieces.'),
                      ),
                      Visibility(
                        visible: _showErrorIdA,
                        child: const Text('Rellena el IdA.'),
                      ),
                    ],
                  )),
            ),
          ),
        )
      );
  }
}
