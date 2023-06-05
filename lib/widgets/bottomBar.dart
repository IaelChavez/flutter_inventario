import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';

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
          buttonBackgroundColor: Colors.redAccent,
          backgroundColor: const Color(0xFF1E1E1E).withOpacity(0.2),
          index: index,
          animationDuration: const Duration(milliseconds: 200),
          items: const [
            CurvedNavigationBarItem(
              child: Icon(
                Icons.supervised_user_circle,
                color: Colors.black54,
              ),
            ),
            CurvedNavigationBarItem(
              child: Icon(
                Icons.add_to_photos_sharp,
                color: Colors.black54,
              ),
            ),
            CurvedNavigationBarItem(
              child: Icon(
                Icons.home,
                color: Colors.black54,
              ),
            ),
            CurvedNavigationBarItem(
              child: Icon(
                Icons.sell,
                color: Colors.black54,
              ),
            ),
            CurvedNavigationBarItem(
              child: Icon(
                Icons.shopping_bag,
                color: Colors.black54,
              ),
            ),
          ],
          onTap:onTap,
        );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}