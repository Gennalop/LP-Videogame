
import 'package:flutter/material.dart';
import 'package:frontend/screens/splash_screen.dart';

void main() {
  runApp(const ReciclajeGameApp());
}

class ReciclajeGameApp extends StatelessWidget {
  const ReciclajeGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Juego de Reciclaje',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

