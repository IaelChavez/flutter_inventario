import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../Model/models.dart';
import '../firebase/firebase_supplier.dart';
import '../firebase/firebase_services.dart';
import '../firebase/firebase_cliente.dart';
import '../widgets/appbar.dart';
import '../widgets/button.dart';
import '../widgets/textField.dart';
import 'lists/lists.dart';

class SupplierScreen extends StatefulWidget {
  String? documentId;
  String? base;

  SupplierScreen({super.key, this.documentId, this.base});

  @override
  _SupplierScreen createState() => _SupplierScreen();
}

Widget SupplierViewFactory(String id, String base) {
  return SupplierScreen(documentId: id, base: base);
}

class _SupplierScreen extends State<SupplierScreen> {
  _SupplierScreen({Key? key}) : super();

  File? _image;
  final picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();

  final List<String> _errors = [];

  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController companyController = TextEditingController();

  bool _showErrorName = false;
  bool _showErrorLastName = false;
  bool _showErrorEmail = false;
  bool _showErrorCompany = false;
  bool _showErrorImage = false;

  String _id = '';
  String _name = '';
  String _lastName = '';
  String _email = '';
  String _company = '';
  String _imageUrl = '';

  vaciarCampos() {
    idController.clear();
    nameController.clear();
    lastNameController.clear();
    emailController.clear();
    companyController.clear();

    _id = '';
    _name = '';
    _lastName = '';
    _email = '';
    _company = '';
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
    idController.addListener(() {
      _id = idController.text;
    });
    nameController.addListener(() {
      _name = nameController.text;
    });
    lastNameController.addListener(() {
      _lastName = lastNameController.text;
    });
    emailController.addListener(() {
      _email = emailController.text;
    });
    companyController.addListener(() {
      _company = companyController.text;
    });

    return Scaffold(
        appBar: const CustomAppBar(
          title: 'Supplier ',
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
                                    controller: idController,
                                    label: 'id',
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    onChanged: (value) {},
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
                                    onChanged: (value) {},
                                  ),
                                  const SizedBox(height: 20),
                                  CustomTextField(
                                    controller: lastNameController,
                                    label: 'Apellido',
                                    keyboardType: TextInputType.text,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[a-zA-Z]'))
                                    ],
                                    onChanged: (value) {},
                                  ),
                                  const SizedBox(height: 20),
                                  CustomTextField(
                                    controller: emailController,
                                    label: 'Correo',
                                    keyboardType: TextInputType.emailAddress,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter
                                          .singleLineFormatter,
                                    ],
                                    onChanged: (value) {},
                                  ),
                                  const SizedBox(height: 20),
                                  CustomTextField(
                                    controller: companyController,
                                    label: 'Compañia',
                                    keyboardType: TextInputType.text,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[a-zA-Z]'))
                                    ],
                                    onChanged: (value) {},
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                            GradientButton(
                              text: 'Guardar',
                              onPressed: () {
                                setState(() {
                                  _showErrorName = false;
                                  _showErrorLastName = false;
                                  _showErrorEmail = false;
                                  _showErrorCompany = false;
                                  _showErrorImage = false;
                                  // Validar cada campo individualmente para mostrar la alerta una por una
                                  if (_validar(_name)) {
                                    _showErrorName = true;
                                  } else if (_validar(_lastName)) {
                                    _showErrorLastName = true;
                                  } else if (_validar(_email)) {
                                    _showErrorEmail = true;
                                  } else if (_validar(_company)) {
                                    _showErrorCompany = true;
                                  } else if (_validar(_imageUrl)) {
                                    _showErrorImage = true;
                                  } else {
                                    // El formulario es válido, envía los datos
                                    try {
                                      addSupplier({
                                        'id': _id,
                                        'name': _name,
                                        'lastName': _lastName,
                                        'email': _email,
                                        'company': _company,
                                        'image': _imageUrl,
                                      });
                                      vaciarCampos();
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SupplierList()));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Compra agregada correctamente')),
                                      );
                                    } catch (e) {}
                                  }
                                });
                              },
                            ),
                            const SizedBox(height: 15),
                            Visibility(
                              visible: _showErrorName,
                              child: const Text('Rellena el nombre.'),
                            ),
                            Visibility(
                              visible: _showErrorLastName,
                              child: const Text('Rellena el Apellido.'),
                            ),
                            Visibility(
                              visible: _showErrorEmail,
                              child: const Text('Rellena el Correo.'),
                            ),
                            Visibility(
                              visible: _showErrorCompany,
                              child: const Text('Rellena la Compañia.'),
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

                      Supplier supplier =
                          Supplier.fromDocumentSnapshot(documentSnapshot);

                      idController.text = supplier.id;
                      nameController.text = supplier.name;
                      lastNameController.text = supplier.lastName;
                      emailController.text = supplier.email;
                      companyController.text = supplier.company;
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
                                          controller: idController,
                                          label: 'id',
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          onChanged: (value) {},
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
                                          onChanged: (value) {},
                                        ),
                                        const SizedBox(height: 20),
                                        CustomTextField(
                                          controller: lastNameController,
                                          label: 'Apellido',
                                          keyboardType: TextInputType.text,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.allow(
                                                RegExp('[a-zA-Z]'))
                                          ],
                                          onChanged: (value) {},
                                        ),
                                        const SizedBox(height: 20),
                                        CustomTextField(
                                          controller: emailController,
                                          label: 'Correo',
                                          onChanged: (value) {},
                                        ),
                                        const SizedBox(height: 20),
                                        CustomTextField(
                                          controller: companyController,
                                          label: 'Compañia',
                                          keyboardType: TextInputType.text,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.allow(
                                                RegExp('[a-zA-Z]'))
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
                                        updateSupplier({
                                          'id': _id,
                                          'name': _name,
                                          'lastName': _lastName,
                                          'email': _email,
                                          'company': _company,
                                          'image': _imageUrl,
                                        }, widget.documentId!);
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const SupplierList()));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Compra actualizada correctamente')),
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
                                          _showErrorName = false;
                                          _showErrorLastName = false;
                                          _showErrorEmail = false;
                                          _showErrorCompany = false;
                                          _showErrorImage = false;
                                          // Validar cada campo individualmente para mostrar la alerta una por una
                                          if (_validar(_name)) {
                                            _showErrorName = true;
                                          } else if (_validar(_lastName)) {
                                            _showErrorLastName = true;
                                          } else if (_validar(_email)) {
                                            _showErrorEmail = true;
                                          } else if (_validar(_company)) {
                                            _showErrorCompany = true;
                                          } else if (_validar(_imageUrl)) {
                                            _showErrorImage = true;
                                          } else {
                                            // El formulario es válido, envía los datos
                                            try {
                                              addSupplier({
                                                'id': _id,
                                                'name': _name,
                                                'lastName': _lastName,
                                                'email': _email,
                                                'company': _company,
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
                                    visible: _showErrorName,
                                    child: const Text('Rellena el nombre.'),
                                  ),
                                  Visibility(
                                    visible: _showErrorLastName,
                                    child: const Text('Rellena el Apellido.'),
                                  ),
                                  Visibility(
                                    visible: _showErrorEmail,
                                    child: const Text('Rellena el Correo.'),
                                  ),
                                  Visibility(
                                    visible: _showErrorCompany,
                                    child: const Text('Rellena la Compañia.'),
                                  ),
                                  Visibility(
                                    visible: _showErrorImage,
                                    child: const Text('Selecciona la imagen.'),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    );
                  }
                }));
  }
}
