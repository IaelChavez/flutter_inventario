import 'package:flutter/material.dart';
import 'package:practica_inventario/screens/screens.dart';

class MenuScreen extends StatelessWidget {
   
  const MenuScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu')),
      body: Center(
         child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Card(
                child:GestureDetector(
                  onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder:(context) => const MenuRegistrosScreen())
                      );
                  },
                  child: const ListTile(
                    leading: Icon(Icons.app_registration_outlined, size: 30,),
                    title: Text("Register",style: TextStyle(
                      fontSize: 20.0
                    )),
                  ),
                )
              ),
              Card(
                child:GestureDetector(
                  onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder:(context) => SalesScreen())
                      );
                  },
                  child: const ListTile(
                    leading: Icon(Icons.sell, size: 30,),
                    title: Text("Sales",style: TextStyle(
                      fontSize: 20.0
                    )),
                  ),
                )
              ),
              Card(
                child:GestureDetector(
                  onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder:(context) =>  PurchaseScreen())
                      );
                  },
                  child: const ListTile(
                    leading: Icon(Icons.shopping_bag, size: 30,),
                    title: Text("Purchase",style: TextStyle(
                      fontSize: 20.0
                    )),
                  ),
                )
              ),

            ],
         )
      ),
    );
  }
}