import 'package:flutter/material.dart';
import 'package:onhb_mobile/data/notifiers.dart';

class SwitchThemeModeBtn extends StatelessWidget {
  const SwitchThemeModeBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        selectedThemeMode.value == ThemeMode.dark
            ? Icons.light_mode
            : Icons.dark_mode,
        color: Colors.white,
      ),
      onPressed: () {
        if (selectedThemeMode.value == ThemeMode.light) {
          selectedThemeMode.value = ThemeMode.dark;
        } else {
          selectedThemeMode.value = ThemeMode.light;
        }
      },
    );
  }
}
