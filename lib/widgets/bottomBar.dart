import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:practica_inventario/themes/colores.dart';

class BottomBar extends StatelessWidget implements PreferredSizeWidget {
  final int index;
  final Function(int) onTap;

  const BottomBar({
    Key? key,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  CurvedNavigationBar(
          height: 60,
          color: AppTheme.primaryAppBarColor,
          buttonBackgroundColor: AppTheme.pressedAppBarColor,
          backgroundColor: AppTheme.backgroundAppBarColor,
          index: index,
          animationDuration: const Duration(milliseconds: 200),
          items: const [
            CurvedNavigationBarItem(
              child: Icon(
                Icons.supervised_user_circle,
                color: Colors.white,
              ),
            ),
            CurvedNavigationBarItem(
              child: Icon(
                Icons.add_to_photos_sharp,
                color: Colors.white,
              ),
            ),
            CurvedNavigationBarItem(
              child: Icon(
                Icons.home,
                color: Colors.white,
              ),
            ),
            CurvedNavigationBarItem(
              child: Icon(
                Icons.sell,
                color: Colors.white,
              ),
            ),
            CurvedNavigationBarItem(
              child: Icon(
                Icons.shopping_bag,
                color: Colors.white,
              ),
            ),
          ],
          onTap:onTap,
        );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}