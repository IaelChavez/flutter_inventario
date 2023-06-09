import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.actions = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: const Color.fromRGBO(10, 100, 79, 0.829),
      title: Row(
        children: [
          const Icon(
            Icons.eco,
            color: Color.fromARGB(255, 17, 194, 29),
            size: 40.0,
          ),
          const SizedBox(width: 15.0),
          Text(
            title,
            style: const TextStyle(
              color: Color.fromARGB(255, 233, 233, 233),
              fontSize: 24.0,
              fontFamily: 'Helvetica',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}