import 'package:flutter/material.dart';
import 'package:onhb_mobile/data/notifiers.dart';

class MainNavigationBar extends StatefulWidget {
  const MainNavigationBar({super.key});

  @override
  State<MainNavigationBar> createState() => _MainNavigationBarState();
}

class _MainNavigationBarState extends State<MainNavigationBar> {
  
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotfier,
      builder: (BuildContext context, dynamic value, Widget? child) {

        return NavigationBar(
          selectedIndex: value,

          onDestinationSelected: (index) {
            selectedPageNotfier.value = index;
          },

          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Home'
            ),

            NavigationDestination(
              icon: Icon(Icons.assignment),
              label: 'Gabarito',
            ),

            NavigationDestination(
              icon: Icon(Icons.assessment),
              label: 'Resultados',
            ),

            NavigationDestination(
              icon: Icon(Icons.person),
              label: 'Equipes'
            ),
          ],

        );

      },
    );
  }
}
