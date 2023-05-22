import 'package:flutter/material.dart';
import 'package:practica_inventario/screens/registerUserScreen.dart';
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
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Login'),
          backgroundColor: Color.fromRGBO(16,44,68, 1),
        ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Container(
              height: 150,
              width: 300, 
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/huron.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Text(
              'Iniciar sesión',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Correo electrónico',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Contraseña',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white
              ),
            ),
            const SizedBox(height: 20),
            GradientButton(
              onPressed: () {
                //  ToDo: Aquí va la lógica para validar los datos de inicio de sesión
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MenuScreen()));
              },
              text: 'Iniciar sesión',
            ),
            const SizedBox(height: 20),
            GradientButton(
              
              onPressed: () {
                //  ToDo: Aquí va la lógica para validar los datos de inicio de sesión
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterUserView()));
              },
              text: 'Registrarse',
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromRGBO(161,32,67,0.822),
    );
  }
}
