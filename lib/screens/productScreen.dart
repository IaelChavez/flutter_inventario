import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practica_inventario/widgets/appbar.dart';
import 'package:practica_inventario/widgets/textField.dart';

import '../widgets/button.dart';

class ProductView extends StatefulWidget {
  @override
  _ProductView createState() => _ProductView();
}

class _ProductView extends State<ProductView> {
  _ProductView({Key? key}) : super();

  final _formKey = GlobalKey<FormState>();

  final List<String> _errors = [];

  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController unitsController = TextEditingController();
  final TextEditingController costController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController utilityController = TextEditingController();

  bool _showErrorId = false;
  bool _showErrorName = false;
  bool _showErrorDescription = false;
  bool _showErrorUnits = false;
  bool _showErrorCost = false;
  bool _showErrorPrice = false;
  bool _showErrorUtility = false;

  String _id = '';
  String _name = '';
  String _descrition = '';
  String _units = '';
  String _cost = '';
  String _price = '';
  String _utility = '';

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
          body: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextField(
                        controller: idController,
                        label: 'id',        
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (value) {
                          setState(() {
                            _id = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: nameController,
                        label: 'nombre',     
                        keyboardType: TextInputType.text,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))
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
                          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))
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
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))
                        ],
                        onChanged: (value) {
                          setState(() {
                            _units = value;
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
                GradientButton(
                  text: 'Guardar',
                  onPressed: () {
                    setState(() {
                      _showErrorId = false;
                      _showErrorName = false;
                      _showErrorDescription = false;
                      _showErrorUnits = false;
                      _showErrorCost = false;
                      _showErrorPrice = false;
                      _showErrorUtility = false;
                      // Validar cada campo individualmente para mostrar la alerta una por una
                      if (_validar(_id)) {
                        _showErrorId = true;
                      }
                      else if (_validar(_name)) {
                        _showErrorName = true;
                      }
                      else if (_validar(_descrition)) {
                        _showErrorDescription = true;
                      }
                      else if (_validar(_units)) {
                        _showErrorUnits = true;
                      }
                      else if (_validar(_cost)) {
                        _showErrorCost = true;
                      }
                      else if (_validar(_price)) {
                        _showErrorPrice = true;
                      }
                      else if (_validar(_utility)) {
                        _showErrorUtility = true;
                      }
                      else {
                        // El formulario es válido, envía los datos
                      }
                    });
                  },
                ),
                const SizedBox(height: 15),
                Visibility(
                  visible: _showErrorId,
                  child: const Text('Rellena el id.'),
                ),
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
            ],)
          ),
        ),
      ),
    );
  }
}
