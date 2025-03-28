import 'package:flutter/material.dart';

class MenuAppBarBtn extends StatelessWidget {
  const MenuAppBarBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.menu),
      color: Colors.white,
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    );
  }
}
