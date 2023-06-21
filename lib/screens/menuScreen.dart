import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practica_inventario/firebase/auth.dart';
import 'package:practica_inventario/screens/screens.dart';
import 'package:practica_inventario/themes/colores.dart';


class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final User? user = Auth().currentUser;
  Future<void> _signOut() async {
    try {
      await Auth().signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen2()),
        (route) => false,
      );
    } catch (e) {
      print(e);
    }
  }

  String? errorMessage = "";

  List<String> tabs = ['Clientes', 'Ferrets', 'Home', 'Sales', 'Suppliers'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppTheme.backgroundColorApp,
            body: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              padding: const EdgeInsets.all(5),
                              height: 50,
                              width: MediaQuery.of(context).size.width / 1.5,
                              decoration: BoxDecoration(
                                  color: AppTheme.primaryColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextFormField(
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: Colors.white,
                                      ),
                                      border: InputBorder.none,
                                      label: Text(
                                        'Search',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )))),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width / 6,
                            decoration: BoxDecoration(
                                color: AppTheme.primaryColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: GestureDetector(
                                  onTap: _signOut,
                                  child: const Icon(
                                    Icons.logout_outlined,
                                    color: Colors.white,
                                  )),
                            ),
                          )
                        ]),
                    const SizedBox(height: 20),
                    Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.asset(
                        'assets/images/banner.jpg',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (var i = 0; i < 5; i++)
                              FittedBox(
                                  child: Container(
                                margin: const EdgeInsets.all(8),
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                height: 40,
                                decoration: BoxDecoration(
                                    color: AppTheme.primaryColor,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                    child: FittedBox(
                                        child: Text(
                                  tabs[i],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ))),
                              ))
                          ],
                        )),
                    const SizedBox(height: 20),
                    Container(
                      height: 450,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.asset(
                        'assets/images/fondo_login.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                )))));
  }
}
