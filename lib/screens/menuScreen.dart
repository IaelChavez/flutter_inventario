import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:practica_inventario/screens/screens.dart';

import '../widgets/appbar.dart';

class MenuScreen extends StatelessWidget {
  MenuScreen({Key? key}) : super(key: key);

  List<String> tabs = ['Users', 'Ferrets', 'Home', 'Sales', 'Shopping'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Container(
                      padding: const EdgeInsets.all(5),
                      height: 50,
                      width: MediaQuery.of(context).size.width / 1.5,
                      decoration: BoxDecoration(
                        color: Colors.black12.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search, color: Color(0xFF676565),),
                          border: InputBorder.none,
                          label: Text('Search', style: TextStyle(color: Color(0xFF676565),),)
                        )
                      )
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 6, 
                      decoration: BoxDecoration(
                        color: Colors.black12.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: const Center(
                        child: Icon(Icons.logout_outlined, color: Colors.redAccent,)
                        ),
                    ),
                  ]
                ),
                const SizedBox(height: 20),
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.black12.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Image.asset('assets/images/banner.jpg', fit: BoxFit.contain,),
                ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for(var i =0; i < 5; i++)
                      FittedBox(
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.only(left:15, right: 15),
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.black12.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Center(
                            child: FittedBox(
                              child: Text(
                                tabs[i],
                                style: const TextStyle(
                                  color: Colors.black38,
                                  fontWeight: FontWeight.w500
                                ),
                              )
                            )
                          ),
                        )
                      )
                    ],
                  )
                ),
                const SizedBox(height: 20),
                Container(
                  height: 450,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.black12.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Image.asset('assets/images/fondo_login.png', fit: BoxFit.cover,),
                ),
              ],
            )
          )
        )
      )
    );
  }
}
