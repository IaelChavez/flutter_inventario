import 'package:flutter/material.dart';
import 'package:practica_inventario/screens/screens.dart';
import 'package:practica_inventario/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  int index = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(
        index: index,
        onTap: (selectedIndex) {
            setState(() {
              index = selectedIndex;
            });
          },
      ),
        body: Container(
          child: getSelectedWidget(index: index),
        )
    );
  }
  Widget getSelectedWidget({required int index}){
    Widget widget;
    switch (index) {
      case 0:
        widget = const ClienteList();
        break;
      case 1:
        widget = const FerretList();
        break;
      case 2:
        widget = MenuScreen();
        break;
      case 3:
        widget = const SaleList();
        break;
      case 4:
        widget = const SupplierList();
        break;
      default:
        widget = MenuScreen();
        break;
    }
    return widget;
  }
}