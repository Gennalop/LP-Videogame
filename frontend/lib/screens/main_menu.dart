import 'package:flutter/material.dart';
import '../widgets/menu_button.dart';
import 'pages/jugar_page.dart';
import 'pages/puntuaciones_page.dart';
import 'pages/comojugar_page.dart';
import 'pages/configuracion_page.dart';
import 'pages/acercade_page.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Menú Principal")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MenuButton(text: "Jugar", page: const JugarPage()),
            MenuButton(text: "Mejores Puntuaciones", page: const PuntuacionesPage()),
            MenuButton(text: "Cómo Jugar", page: const ComojugarPage()),
            MenuButton(text: "Configuración", page: const ConfiguracionPage()),
            MenuButton(text: "Acerca de", page: const AcercadePage()),
          ],
        ),
      ),
    );
  }
}
