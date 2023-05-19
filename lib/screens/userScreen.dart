import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practica_inventario/firebase/firebase_user.dart';
import 'package:practica_inventario/widgets/appbar.dart';
import 'package:practica_inventario/widgets/textField.dart';

import '../Model/UserModel.dart';
import '../controllers/dataItem.dart';
import '../firebase/firebase_services.dart';
import '../widgets/button.dart';

class userView extends StatefulWidget {
  String? documentId;
  String? base;

  userView({super.key, this.documentId, this.base});

  @override
  _userView createState() => _userView();
}

Widget UserViewFactory(String id, String base) {
  return userView(documentId: id, base: base);
}

class _userView extends State<userView> {
  late Object item;
  _userView({Key? key}) : super();

  final _formKey = GlobalKey<FormState>();

  // ignore: unused_field
  final List<String> _errors = [];

  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _showErrorId = false;
  bool _showErrorName = false;
  bool _showErrorLastName = false;
  bool _showErrorAge = false;
  bool _showErrorGender = false;
  bool _showErrorEmail = false;
  bool _showErrorPassword = false;

  String _name = '';
  String _lastName = '';
  String _age = '';
  String _gender = '';
  String _email = '';
  String _password = '';

  vaciarCampos() {
    idController.clear();
    nameController.clear();
    lastNameController.clear();
    ageController.clear();
    genderController.clear();
    emailController.clear();
    passwordController.clear();

    _name = '';
    _lastName = '';
    _age = '';
    _gender = '';
    _email = '';
    _password = '';
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
    lastNameController.addListener(() {
      _lastName = lastNameController.text;
    });
    ageController.addListener(() {
      _age = ageController.text;
    });
    genderController.addListener(() {
      _gender = genderController.text;
    });
    emailController.addListener(() {
      _email = emailController.text;
    });
    passwordController.addListener(() {
      _password = passwordController.text;
    });

    return Scaffold(
        appBar: const CustomAppBar(
          title: 'User ',
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
                                        onChanged: (value) {},
                                      ),
                                      const SizedBox(height: 20),
                                      CustomTextField(
                                        controller: lastNameController,
                                        label: 'apellido',
                                        keyboardType: TextInputType.text,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(
                                              RegExp('[a-zA-Z]'))
                                        ],
                                        onChanged: (value) {},
                                      ),
                                      const SizedBox(height: 20),
                                      CustomTextField(
                                        controller: ageController,
                                        label: 'edad',
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        onChanged: (value) {},
                                      ),
                                      const SizedBox(height: 20),
                                      CustomTextField(
                                        controller: genderController,
                                        label: 'genero',
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
                                        label: 'correo',
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter
                                              .singleLineFormatter,
                                        ],
                                        onChanged: (value) {},
                                      ),
                                      const SizedBox(height: 20),
                                      CustomTextField(
                                        controller: passwordController,
                                        label: 'contraseña',
                                        obscureText: true,
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
                                      updatedUser({
                                        "name": _name,
                                        "lastName": _lastName,
                                        "age": _age,
                                        "gender": _gender,
                                        "email": _email,
                                        "password": _password,
                                      }, widget.documentId!);
                                    },
                                    text: 'Actualizar',
                                  ),
                                ),
                                Visibility(
                                  visible: widget.documentId == null,
                                  child: GradientButton(
                                    onPressed: () {
                                      setState(() {
                                        _showErrorId = false;
                                        _showErrorName = false;
                                        _showErrorLastName = false;
                                        _showErrorAge = false;
                                        _showErrorGender = false;
                                        _showErrorEmail = false;
                                        _showErrorPassword = false;
                                        // Validar cada campo individualmente para mostrar la alerta una por una
                                        if (_validar(_name)) {
                                          _showErrorName = true;
                                        } else if (_validar(_lastName)) {
                                          _showErrorLastName = true;
                                        } else if (_validar(_age)) {
                                          _showErrorAge = true;
                                        } else if (_validar(_gender)) {
                                          _showErrorGender = true;
                                        } else if (_validar(_email)) {
                                          _showErrorEmail = true;
                                        } else if (_validar(_password)) {
                                          _showErrorPassword = true;
                                        } else {
                                          // El formulario es válido, envía los datos
                                          try {
                                            addUser({
                                              "name": _name,
                                              "lastName": _lastName,
                                              "age": _age,
                                              "gender": _gender,
                                              "email": _email,
                                              "password": _password,
                                            });
                                            vaciarCampos();
                                          } catch (e) {}
                                        }
                                      });
                                    },
                                    text: 'Guardar',
                                  ),
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
                                  visible: _showErrorLastName,
                                  child: const Text('Rellena el apellido.'),
                                ),
                                Visibility(
                                  visible: _showErrorAge,
                                  child: const Text('Rellena la edad.'),
                                ),
                                Visibility(
                                  visible: _showErrorGender,
                                  child: const Text('Rellena el genero.'),
                                ),
                                Visibility(
                                  visible: _showErrorEmail,
                                  child: const Text('Rellena el correo.'),
                                ),
                                Visibility(
                                  visible: _showErrorPassword,
                                  child: const Text('Rellena la contraseña.'),
                                ),
                              ],
                            )))))
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

                      User uuser = User.fromDocumentSnapshot(documentSnapshot);

                      nameController.text = uuser.name;
                      lastNameController.text = uuser.lastName;
                      ageController.text = uuser.age;
                      genderController.text = uuser.gender;
                      emailController.text = uuser.email;
                      passwordController.text = uuser.password;
                    } else {
                      nameController.text = '';
                      lastNameController.text = '';
                      ageController.text = '';
                      genderController.text = '';
                      emailController.text = '';
                      passwordController.text = '';
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
                                            controller: lastNameController,
                                            label: 'apellido',
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
                                            controller: ageController,
                                            label: 'edad',
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
                                            controller: genderController,
                                            label: 'genero',
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
                                            controller: emailController,
                                            label: 'correo',
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .singleLineFormatter,
                                            ],
                                            onChanged: (value) {},
                                          ),
                                          const SizedBox(height: 20),
                                          CustomTextField(
                                            controller: passwordController,
                                            label: 'contraseña',
                                            obscureText: true,
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
                                          updatedUser({
                                            "name": _name,
                                            "lastName": _lastName,
                                            "age": _age,
                                            "gender": _gender,
                                            "email": _email,
                                            "password": _password,
                                          }, widget.documentId!);
                                        },
                                        text: 'Actualizar',
                                      ),
                                    ),
                                    Visibility(
                                      visible: widget.documentId == null,
                                      child: GradientButton(
                                        onPressed: () {
                                          setState(() {
                                            _showErrorId = false;
                                            _showErrorName = false;
                                            _showErrorLastName = false;
                                            _showErrorAge = false;
                                            _showErrorGender = false;
                                            _showErrorEmail = false;
                                            _showErrorPassword = false;
                                            // Validar cada campo individualmente para mostrar la alerta una por una
                                            if (_validar(_name)) {
                                              _showErrorName = true;
                                            } else if (_validar(_lastName)) {
                                              _showErrorLastName = true;
                                            } else if (_validar(_age)) {
                                              _showErrorAge = true;
                                            } else if (_validar(_gender)) {
                                              _showErrorGender = true;
                                            } else if (_validar(_email)) {
                                              _showErrorEmail = true;
                                            } else if (_validar(_password)) {
                                              _showErrorPassword = true;
                                            } else {
                                              // El formulario es válido, envía los datos
                                              try {
                                                addUser({
                                                  "name": _name,
                                                  "lastName": _lastName,
                                                  "age": _age,
                                                  "gender": _gender,
                                                  "email": _email,
                                                  "password": _password,
                                                });
                                                vaciarCampos();
                                              } catch (e) {}
                                            }
                                          });
                                        },
                                        text: 'Guardar',
                                      ),
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
                                      visible: _showErrorLastName,
                                      child: const Text('Rellena el apellido.'),
                                    ),
                                    Visibility(
                                      visible: _showErrorAge,
                                      child: const Text('Rellena la edad.'),
                                    ),
                                    Visibility(
                                      visible: _showErrorGender,
                                      child: const Text('Rellena el genero.'),
                                    ),
                                    Visibility(
                                      visible: _showErrorEmail,
                                      child: const Text('Rellena el correo.'),
                                    ),
                                    Visibility(
                                      visible: _showErrorPassword,
                                      child:
                                          const Text('Rellena la contraseña.'),
                                    ),
                                  ],
                                )),
                          ),
                        ));
                  }
                }));
  }
}
