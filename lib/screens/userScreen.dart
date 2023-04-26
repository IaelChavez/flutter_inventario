import 'package:flutter/material.dart';
import 'package:practica_inventario/widgets/appbar.dart';
import 'package:practica_inventario/widgets/textField.dart';

class userView extends StatefulWidget {
  @override
  _userView createState() => _userView();
}

class _userView extends State<userView> {
  _userView({Key? key}) : super();

  final _formKey = GlobalKey<FormState>();

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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // submit form data
    }
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
            icon: Icon(Icons.search),
            onPressed: () {
              // Implementar funcionalidad de búsqueda
            },
          ),
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Implementar funcionalidad de menú
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
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
            margin: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
            padding: EdgeInsets.all(20.0),
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
                        onChanged: (value) {
                          setState(() {
                            _id = value;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        controller: nameController,
                        label: 'nombre',      
                        onChanged: (value) {
                          setState(() {
                            _name = value;
                          });
                        }, 
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        controller: lastNameController,
                        label: 'apellido',        
                        onChanged: (value) {
                          setState(() {
                            _lastName = value;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        controller: ageController,
                        label: 'edad',        
                        onChanged: (value) {
                          setState(() {
                            _age = value;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        controller: genderController,
                        label: 'genero',        
                        onChanged: (value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        controller: emailController,
                        label: 'correo', 
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          setState(() {
                            _email = value;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        controller: passwordController,
                        label: 'contra',
                        obscureText: true,
                        onChanged: (value) {
                          setState(() {
                            _password = value;
                          });
                        },
                      ),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
                Visibility(
                  visible: _showErrorId,
                  child: Text('Rellena el id.'),
                ),
                Visibility(
                  visible: _showErrorName,
                  child: Text('Rellena el nombre.'),
                ),
                Visibility(
                  visible: _showErrorLastName,
                  child: Text('Rellena el apellido.'),
                ),
                 Visibility(
                  visible: _showErrorAge,
                  child: Text('Rellena la edad.'),
                ),
                 Visibility(
                  visible: _showErrorGender,
                  child: Text('Rellena el genero.'),
                ),
                 Visibility(
                  visible: _showErrorEmail,
                  child: Text('Rellena el correo.'),
                ),
                 Visibility(
                  visible: _showErrorPassword,
                  child: Text('Rellena la contraseña.'),
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
                      }
                      else if (_validar(_name)) {
                        _showErrorName = true;
                      }
                      else if (_validar(_lastName)) {
                        _showErrorLastName = true;
                      }
                      else if (_validar(_age)) {
                        _showErrorAge = true;
                      }
                      else if (_validar(_gender)) {
                        _showErrorGender = true;
                      }
                      else if (_validar(_email)) {
                        _showErrorEmail = true;
                      }
                      else if (_validar(_password)) {
                        _showErrorPassword = true;
                      }
                      else {
                        // El formulario es válido, envía los datos
                      }
                    });
                  },
                  child: Text('Guardar'),
                ),
            ],)
          ),
        ),
      ),
    );
  }
}
