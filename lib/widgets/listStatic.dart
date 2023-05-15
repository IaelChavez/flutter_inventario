import 'package:flutter/material.dart';
import 'package:practica_inventario/Model/user.dart';
import 'package:practica_inventario/widgets/widgets.dart';

class UserList extends StatelessWidget {
  final List<User> user;
  final IconData leadingIcon;
  final VoidCallback? onEditPressed;
  final VoidCallback? onDeletePressed;
  final VoidCallback? onTap;

  UserList(
      {required this.user,
      required this.leadingIcon,
      this.onEditPressed,
      this.onDeletePressed,
      this.onTap});

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
          body: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin:
                const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
            padding: const EdgeInsets.all(20.0),
            child: ListView.builder(
              itemCount: user.length,
              itemBuilder: (context, index) {
                final usuario = user[index];
                return Container(
                  height: 80, // Alto deseado del Card
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.white,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 17,
                        backgroundColor: Colors.blue,
                        child: Icon(
                          leadingIcon,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(usuario.nombre),
                      subtitle: Text(usuario.precio),
                      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: onEditPressed,
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: onDeletePressed,
                        ),
                      ]),
                      onTap: onTap,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
