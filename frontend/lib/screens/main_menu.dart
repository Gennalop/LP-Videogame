import 'package:flutter/material.dart';
import '../widgets/menu_button.dart';
import 'pages/jugar_page.dart';
import 'pages/puntuaciones_page.dart';
import 'pages/comojugar_page.dart';
import 'pages/configuracion_page.dart';
import 'pages/acercade_page.dart';
import 'pages/estadisticas_page.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF74ebd5), Color(0xFFACB6E5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
          child: Column(
            children: [
              // ---- Puntuación arriba a la derecha ----
              /*
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: const Text(
                    "Mejor: 150 ⭐",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              */
              const SizedBox(height: 40),

              // ---- Logo y título ----
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('images/logo.png'), // pon tu imagen
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(height: 16),
              const Text(
                "EchoCatch",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Text(
                "Salva el Planeta Reciclando",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 40),

              // ---- Botones ----
              MenuButton(
                text: "Jugar ahora",
                page: const JugarPage(),
                backgroundColor: Colors.orange,
                icon: Icons.sports_esports,
                textColor: Colors.white,
              ),
              MenuButton(
                text: "Mejores puntuaciones",
                page: const PuntuacionesPage(),
                backgroundColor: Colors.green,
                icon: Icons.star,
                textColor: Colors.white,
              ),
              MenuButton(
                text: "Tus estadísticas",
                page: const EstadisticasPage(jugador: "Player"),
                backgroundColor: Colors.green,
                icon: Icons.bar_chart,
                textColor: Colors.white,
              ),
              MenuButton(
                text: "Cómo jugar",
                page: const ComojugarPage(),
                backgroundColor: Colors.green,
                icon: Icons.school,
                textColor: Colors.white,
              ),
              MenuButton(
                text: "Configuración",
                page: const ConfiguracionPage(),
                backgroundColor: Colors.green,
                icon: Icons.settings,
                textColor: Colors.white,
              ),
              MenuButton(
                text: "Acerca del juego",
                page: const AcercadePage(),
                backgroundColor: Colors.grey.shade700,
                icon: Icons.info,
                textColor: Colors.white,
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
        ),
      ),
    );
  }
}

