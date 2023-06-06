import 'package:flutter/material.dart';
import 'package:practica_inventario/screens/home_screen.dart';

import '../widgets/button.dart';
import 'registerUserScreen.dart';
import 'screens.dart';

class LoginScreen2 extends StatelessWidget {
  LoginScreen2({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: AssetImage("assets/images/fondo_login.png"),
              fit: BoxFit.cover,
              opacity: 0.5,
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(children: [
                const Text(
                  'Iniciar sesión',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 20),
                TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      hintText: 'Correo electrónico',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    style: const TextStyle(color: Colors.white)),
                const SizedBox(height: 20),
                TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      hintText: 'Contraseña',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    style: const TextStyle(color: Colors.white)),
                const SizedBox(height: 20),
                GradientButton(
                  onPressed: () {
                    //  ToDo: Aquí va la lógica para validar los datos de inicio de sesión
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                  },
                  text: 'Iniciar sesión',
                ),
                const SizedBox(height: 20),
                GradientButton(
                  onPressed: () {
                    //  ToDo: Aquí va la lógica para validar los datos de inicio de sesión
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterUserView()));
                  },
                  text: 'Registrarse',
                ),
              ]),
            ),
          ],
        ),
      ),
    );

  }
}
