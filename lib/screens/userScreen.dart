import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practica_inventario/firebase/firebase_services.dart';
import 'package:practica_inventario/widgets/appbar.dart';
import 'package:practica_inventario/widgets/textField.dart';

class userView extends StatefulWidget {
  @override
  _userView createState() => _userView();
}

class _userView extends State<userView> {
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

  String _id = '';
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

    _id = '';
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
                              controller: lastNameController,
                              label: 'apellido',
                              keyboardType: TextInputType.text,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp('[a-zA-Z]'))
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _lastName = value;
                                });
                              },
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              controller: ageController,
                              label: 'edad',
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
                              controller: genderController,
                              label: 'genero',
                              keyboardType: TextInputType.text,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp('[a-zA-Z]'))
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _gender = value;
                                });
                              },
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              controller: emailController,
                              label: 'correo',
                              keyboardType: TextInputType.emailAddress,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.singleLineFormatter,
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _email = value;
                                });
                              },
                            ),
                            const SizedBox(height: 20),
                            CustomTextField(
                              controller: passwordController,
                              label: 'contraseña',
                              obscureText: true,
                              onChanged: (value) {
                                setState(() {
                                  _password = value;
                                });
                              },
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                      ElevatedButton(
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
                            if (_validar(_id)) {
                              _showErrorId = true;
                            } else if (_validar(_name)) {
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
                                  "id": _id,
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
                        child: const Text('Guardar'),
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
                  )),
            ),
          ),
        ));
  }
}
