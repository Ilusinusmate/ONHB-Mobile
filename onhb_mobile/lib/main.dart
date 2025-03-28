import 'package:flutter/material.dart';
import 'package:onhb_mobile/data/notifiers.dart';
import 'package:onhb_mobile/data/storage_system.dart';
import 'package:onhb_mobile/views/widget_tree.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    print("Flutter binding initialized");
    
    // Clear all data and start fresh (temporary fix)
    // await Hive.deleteFromDisk();
    // print("Deleted all Hive data from disk");
    
    await StorageSystem.initHive();
    print("Storage system initialized");
    
    runApp(const MyApp());
  } catch (e) {
    print("Fatal error during initialization: $e");
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static final themeModeMap = {
    ThemeMode.system: Brightness.light,
    ThemeMode.dark: Brightness.dark,
    ThemeMode.light: Brightness.light,
  };

  static final textColorMap = {
    ThemeMode.dark: Colors.white,
    ThemeMode.system: Colors.black,
    ThemeMode.light: Colors.black,
  };

  static final cardColorMap = {
    ThemeMode.dark: const Color.fromARGB(255, 25, 26, 27),
    ThemeMode.light: const Color(0xffd9d9d9),
    ThemeMode.system: const Color(0xffd9d9d9),
  };

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedThemeMode,
      builder: (context, value, child) {
        return MaterialApp(
          title: 'ONHB Mobile',
          debugShowCheckedModeBanner: false,

          home: WidgetTree(),

          theme: ThemeData(
            primaryColor: Color(0xffc60071),
            cardColor: cardColorMap[value]!,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Color(0xffc60071),
              // secondary: Color(0xffc60071),
              brightness: themeModeMap[value]!,
            ),

            textTheme: TextTheme(
              bodyMedium: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textColorMap[value]!,
              ),

              bodyLarge: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColorMap[value]!,
              ),

              bodySmall: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColorMap[value]!,
              ),
            ),
          ),
        );
      },
    );
  }
}
