import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practica_inventario/widgets/appbar.dart';
import 'package:practica_inventario/widgets/textField.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../Model/models.dart';
import '../firebase/firebase_ferret.dart';
import '../firebase/firebase_services.dart';
import '../widgets/button.dart';
import 'lists/lists.dart';

class FerretView extends StatefulWidget {
  String? documentId;
  String? base;

  FerretView({super.key, this.documentId, this.base});

  @override
  _FerretView createState() => _FerretView();
}

Widget FerretViewFactory(String id, String base) {
  return FerretView(documentId: id, base: base);
}

class _FerretView extends State<FerretView> {
  File? _image;
  final picker = ImagePicker();
  _FerretView({Key? key}) : super();

  final _formKey = GlobalKey<FormState>();

  final List<String> _errors = [];

  final TextEditingController speciesController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();

  bool _showErrorSpecies = false;
  bool _showErrorAge = false;
  bool _showErrorColor = false;
  bool _showErrorPrice = false;
  bool _showErrorNationality = false;
  bool _showErrorImage = false;

  String _species = '';
  String _age = '';
  String _color = '';
  String _price = '';
  String _nationality = '';
  String _imageUrl = '';

  vaciarCampos() {
    speciesController.clear();
    ageController.clear();
    colorController.clear();
    priceController.clear();
    nationalityController.clear();

    _species = '';
    _age = '';
    _color = '';
    _price = '';
    _nationality = '';
    _imageUrl = '';
  }

  bool _validar(String value) {
    if (value.isEmpty) {
      return true;
    }
    return false;
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<String> uploadImageToFirebase() async {
    if (_image == null) {
      throw Exception('No se ha seleccionado una imagen');
    }

    firebase_storage.Reference storageReference = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');

    firebase_storage.UploadTask uploadTask = storageReference.putFile(_image!);
    firebase_storage.TaskSnapshot taskSnapshot =
        await uploadTask.whenComplete(() => null);

    return await taskSnapshot.ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    speciesController.addListener(() {
      _species = speciesController.text;
    });
    ageController.addListener(() {
      _age = ageController.text;
    });
    colorController.addListener(() {
      _color = colorController.text;
    });
    priceController.addListener(() {
      _price = priceController.text;
    });
    nationalityController.addListener(() {
      _nationality = priceController.text;
    });

    return Scaffold(
        appBar: const CustomAppBar(
          title: 'Ferrets',
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
                                  _image == null
                                      ? Icon(Icons.add_a_photo,
                                          size: 50, color: Colors.grey)
                                      : Container(
                                          width: 200,
                                          height: 200,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.file(
                                              _image!,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () async {
                                      await getImage();
                                    },
                                    child: const Text('Seleccionar'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      try {
                                        _imageUrl =
                                            await uploadImageToFirebase();
                                        print(
                                            'Imagen subida a Firebase Storage: $_imageUrl');
                                      } catch (e) {
                                        print('Error al subir la imagen: $e');
                                      }
                                    },
                                    child: Text('Subir a Firebase'),
                                  ),
                                  const SizedBox(height: 20),
                                  CustomTextField(
                                    controller: speciesController,
                                    label: 'Especie',
                                    keyboardType: TextInputType.text,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[a-zA-Z]'))
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _species = value;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  CustomTextField(
                                    controller: ageController,
                                    label: 'Edad',
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _age = value;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  CustomTextField(
                                    controller: colorController,
                                    label: 'Color',
                                    keyboardType: TextInputType.text,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[a-zA-Z]'))
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _color = value;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  CustomTextField(
                                    controller: priceController,
                                    label: 'Precio',
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
                                    controller: nationalityController,
                                    label: 'Nacionalidad',
                                    keyboardType: TextInputType.text,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[a-zA-Z]'))
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _nationality = value;
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
                                  updateFerrets({
                                    'species': _species,
                                    'age': _age,
                                    'color': _color,
                                    'price': _price,
                                    'nationality': _nationality,
                                    'image': _imageUrl,
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
                                    _showErrorSpecies = false;
                                    _showErrorAge = false;
                                    _showErrorColor = false;
                                    _showErrorPrice = false;
                                    _showErrorNationality = false;
                                    // Validar cada campo individualmente para mostrar la alerta una por una
                                    if (_validar(_species)) {
                                      _showErrorSpecies = true;
                                    } else if (_validar(_age)) {
                                      _showErrorAge = true;
                                    } else if (_validar(_color)) {
                                      _showErrorColor = true;
                                    } else if (_validar(_price)) {
                                      _showErrorPrice = true;
                                    } else if (_validar(_nationality)) {
                                      _showErrorNationality = true;
                                    } else {
                                      // El formulario es válido, envía los datos
                                      try {
                                        addFerret({
                                          'species': _species,
                                          'age': _age,
                                          'color': _color,
                                          'price': _price,
                                          'nationality': _nationality,
                                          'image': _imageUrl,
                                        });
                                        vaciarCampos();
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const FerretList()));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Huron agregado correctamente')),
                                        );
                                      } catch (e) {}
                                    }
                                  });
                                },
                              ),
                            ),
                            const SizedBox(height: 15),
                            Visibility(
                              visible: _showErrorSpecies,
                              child: const Text('Rellena la Especie.'),
                            ),
                            Visibility(
                              visible: _showErrorAge,
                              child: const Text('Rellena la edad.'),
                            ),
                            Visibility(
                              visible: _showErrorColor,
                              child: const Text('Rellena el Color.'),
                            ),
                            Visibility(
                              visible: _showErrorPrice,
                              child: const Text('Rellena el Precio.'),
                            ),
                            Visibility(
                              visible: _showErrorNationality,
                              child: const Text('Rellena la Nacionalidad.'),
                            ),
                            Visibility(
                              visible: _showErrorImage,
                              child: const Text('Selecciona la imagen.'),
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

                      Ferret ferret =
                          Ferret.fromDocumentSnapshot(documentSnapshot);

                      speciesController.text = ferret.species;
                      ageController.text = ferret.age;
                      colorController.text = ferret.color;
                      priceController.text = ferret.price;
                      nationalityController.text = ferret.nationality;
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
                                            controller: speciesController,
                                            label: 'Especie',
                                            keyboardType: TextInputType.text,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter.allow(
                                                  RegExp('[a-zA-Z]'))
                                            ],
                                            onChanged: (value) {
                                              setState(() {
                                                _species = value;
                                              });
                                            },
                                          ),
                                          const SizedBox(height: 20),
                                          CustomTextField(
                                            controller: ageController,
                                            label: 'Edad',
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            onChanged: (value) {
                                              setState(() {
                                                _age = value;
                                              });
                                            },
                                          ),
                                          const SizedBox(height: 20),
                                          CustomTextField(
                                            controller: colorController,
                                            label: 'Color',
                                            keyboardType: TextInputType.text,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter.allow(
                                                  RegExp('[a-zA-Z]'))
                                            ],
                                            onChanged: (value) {
                                              setState(() {
                                                _color = value;
                                              });
                                            },
                                          ),
                                          const SizedBox(height: 20),
                                          CustomTextField(
                                            controller: priceController,
                                            label: 'Precio',
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            onChanged: (value) {
                                              setState(() {
                                                _price = value;
                                              });
                                            },
                                          ),
                                          const SizedBox(height: 20),
                                          CustomTextField(
                                            controller: nationalityController,
                                            label: 'Nacionalidad',
                                            keyboardType: TextInputType.text,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter.allow(
                                                  RegExp('[a-zA-Z]'))
                                            ],
                                            onChanged: (value) {
                                              setState(() {
                                                _nationality = value;
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
                                          updateFerrets({
                                            'species': _species,
                                            'age': _age,
                                            'color': _color,
                                            'price': _price,
                                            'nationality': _nationality,
                                            'image': _imageUrl,
                                          }, widget.documentId!);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const FerretList()));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'Huron actualizado correctamente')),
                                          );
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
                                            _showErrorSpecies = false;
                                            _showErrorAge = false;
                                            _showErrorColor = false;
                                            _showErrorPrice = false;
                                            _showErrorNationality = false;
                                            // Validar cada campo individualmente para mostrar la alerta una por una
                                            if (_validar(_species)) {
                                              _showErrorSpecies = true;
                                            } else if (_validar(_age)) {
                                              _showErrorAge = true;
                                            } else if (_validar(_color)) {
                                              _showErrorColor = true;
                                            } else if (_validar(_price)) {
                                              _showErrorPrice = true;
                                            } else if (_validar(_nationality)) {
                                              _showErrorNationality = true;
                                            } else {
                                              // El formulario es válido, envía los datos
                                              try {
                                                addFerret({
                                                  'species': _species,
                                                  'age': _age,
                                                  'units': _color,
                                                  'price': _price,
                                                  'nationality': _nationality,
                                                  'image': _imageUrl,
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
                                      visible: _showErrorSpecies,
                                      child: const Text('Rellena la Especie.'),
                                    ),
                                    Visibility(
                                      visible: _showErrorAge,
                                      child: const Text('Rellena la edad.'),
                                    ),
                                    Visibility(
                                      visible: _showErrorColor,
                                      child: const Text('Rellena el Color.'),
                                    ),
                                    Visibility(
                                      visible: _showErrorPrice,
                                      child: const Text('Rellena el Precio.'),
                                    ),
                                    Visibility(
                                      visible: _showErrorNationality,
                                      child: const Text(
                                          'Rellena la Nacionalidad.'),
                                    ),
                                    Visibility(
                                      visible: _showErrorImage,
                                      child:
                                          const Text('Selecciona la imagen.'),
                                    ),
                                  ],
                                )),
                          ),
                        ));
                  }
                }));
  }
}
