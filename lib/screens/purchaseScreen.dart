import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practica_inventario/firebase/firebase_services.dart';

import '../widgets/appbar.dart';
import '../widgets/button.dart';
import '../widgets/textField.dart';

class PurchaseScreen extends StatefulWidget {
  @override
  _PurchaseScreen createState() => _PurchaseScreen();
}

class _PurchaseScreen extends State<PurchaseScreen> {
  _PurchaseScreen({Key? key}) : super();

  final _formKey = GlobalKey<FormState>();

  final List<String> _errors = [];

  final TextEditingController idProductController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cantController = TextEditingController();
  final TextEditingController idVController = TextEditingController();
  final TextEditingController idCController = TextEditingController();
  final TextEditingController piecesController = TextEditingController();
  final TextEditingController subTotalController = TextEditingController();
  final TextEditingController totalController = TextEditingController();

  bool _showErrorIdProduct = false;
  bool _showErrorName = false;
  bool _showErrorCant = false;
  bool _showErrorIdV = false;
  bool _showErrorIdC = false;
  bool _showErrorPieces = false;
  bool _showErrorSubtotal = false;
  bool _showErrorTotal = false;

  String _idProduct = '';
  String _name = '';
  String _cant = '';
  String _idV = '';
  String _idC = '';
  String _pieces = '';
  String _subtotal = '';
  String _total = '';

  vaciarCampos() {
    idProductController.clear();
    nameController.clear();
    cantController.clear();
    idVController.clear();
    idCController.clear();
    piecesController.clear();
    subTotalController.clear();
    totalController.clear();

    _idProduct = '';
    _name = '';
    _cant = '';
    _idV = '';
    _idC = '';
    _pieces = '';
    _subtotal = '';
    _total = '';
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
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // Implementar funcionalidad de búsqueda
              },
            ),
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                // Implementar funcionalidad de menú
              },
            ),
          ],
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
                              controller: cantController,
                              label: 'Cantidad',
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _cant = value;
                                });
                              },
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              controller: idVController,
                              label: 'IdV',
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _idV = value;
                                });
                              },
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              controller: idCController,
                              label: 'IdC',
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _idC = value;
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
                              controller: subTotalController,
                              label: 'Subtotal',
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _subtotal = value;
                                });
                              },
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              controller: totalController,
                              label: 'Total',
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _total = value;
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
                            _showErrorCant = false;
                            _showErrorIdV = false;
                            _showErrorIdC = false;
                            _showErrorPieces = false;
                            _showErrorSubtotal = false;
                            _showErrorTotal = false;
                            // Validar cada campo individualmente para mostrar la alerta una por una
                            if (_validar(_idProduct)) {
                              _showErrorIdProduct = true;
                            } else if (_validar(_name)) {
                              _showErrorName = true;
                            } else if (_validar(_cant)) {
                              _showErrorCant = true;
                            } else if (_validar(_idV)) {
                              _showErrorIdV = true;
                            } else if (_validar(_idC)) {
                              _showErrorIdC = true;
                            } else if (_validar(_pieces)) {
                              _showErrorPieces = true;
                            } else if (_validar(_subtotal)) {
                              _showErrorSubtotal = true;
                            } else if (_validar(_total)) {
                              _showErrorTotal = true;
                            } else {
                              // El formulario es válido, envía los datos
                              try {
                                addPurchase({
                                  'idProduct': _idProduct,
                                  'name': _name,
                                  'cant': _cant,
                                  'idV': _idV,
                                  'idC': _idC,
                                  'pieces': _pieces,
                                  'subtotal': _subtotal,
                                  'total': _total,
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
                        visible: _showErrorCant,
                        child: const Text('Rellena Cantidad.'),
                      ),
                      Visibility(
                        visible: _showErrorIdV,
                        child: const Text('Rellena idV.'),
                      ),
                      Visibility(
                        visible: _showErrorIdC,
                        child: const Text('Rellena idC.'),
                      ),
                      Visibility(
                        visible: _showErrorPieces,
                        child: const Text('Rellena pieces.'),
                      ),
                      Visibility(
                        visible: _showErrorSubtotal,
                        child: const Text('Rellena el subtotal.'),
                      ),
                      Visibility(
                        visible: _showErrorTotal,
                        child: const Text('Rellena el total.'),
                      ),
                    ],
                  )),
            ),
          ),
        )
      );
  }
}
