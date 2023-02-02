import 'package:calculator_app_getx/screens/calculator_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black), // standard dark theme
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const CalculatorScreen(),
    );
  }
}
