import 'package:flutter/material.dart';
import 'package:practica_inventario/screens/screens.dart';

class MenuRegistrosScreen extends StatelessWidget {
  const MenuRegistrosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Registros'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Card(
                child:GestureDetector(
                  onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder:(context) => userView())
                      );
                  },
                  child: const ListTile(
                    leading: Icon(Icons.person_add, size: 30,),
                    title: Text("Users",style: TextStyle(
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
                        MaterialPageRoute(builder:(context) => ProductView())
                      );
                  },
                  child: const ListTile(
                    leading: Icon(Icons.add_to_photos_sharp, size: 30,),
                    title: Text("Products",style: TextStyle(
                      fontSize: 20.0
                    )),
                  ),
                )
              ),
        ],
      )),
    );
  }
}
