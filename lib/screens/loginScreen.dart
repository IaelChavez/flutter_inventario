import 'package:flutter/material.dart';
import 'package:practica_inventario/screens/screens.dart';

import '../widgets/appbar.dart';
import '../widgets/button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Login ',
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Iniciar sesión',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Correo electrónico',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            GradientButton(
              onPressed: () {
                //  ToDo: Aquí va la lógica para validar los datos de inicio de sesión
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MenuScreen()));
              },
              text: 'Iniciar sesión',
            ),
            const SizedBox(height: 20),
            GradientButton(
              onPressed: () {
                //  ToDo: Aquí va la lógica para validar los datos de inicio de sesión
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ClienteView()));
              },
              text: 'Registrarse',
            ),
          ],
        ),
      ),
    );
  }
}
