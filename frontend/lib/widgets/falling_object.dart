import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class FallingObject extends StatefulWidget {
  final Function(bool isCorrect, double x, double y) onObjectCaught;
  final bool isPaused;
  final double initialX;

  const FallingObject({
    super.key,
    required this.onObjectCaught,
    this.isPaused = false,
    this.initialX = 0,
  });

  @override
  _FallingObjectState createState() => _FallingObjectState();
}

class _FallingObjectState extends State<FallingObject> {
  double top = 0;
  double left = 0;
  Timer? timer;
  late GameObjectType currentObject;
  final Random random = Random();

  final List<GameObjectType> gameObjects = [
    // Reciclables (sí suman puntos) → verde
    GameObjectType(
      id: 'paper',
      icon: Icons.description,
      color: Colors.green,
      name: 'Papel',
      category: 'paper',
      isTrash: true,
    ),
    GameObjectType(
      id: 'bottle',
      icon: Icons.local_drink,
      color: Colors.green,
      name: 'Botella',
      category: 'plastic',
      isTrash: true,
    ),
    GameObjectType(
      id: 'can',
      icon: Icons.local_cafe,
      color: Colors.green,
      name: 'Lata',
      category: 'metal',
      isTrash: true,
    ),

    // No reciclables (penalización si se atrapan) → rojo
    GameObjectType(
      id: 'battery',
      icon: Icons.battery_full,
      color: Colors.red,
      name: 'Batería',
      category: 'electronics',
      isTrash: false,
    ),
    GameObjectType(
      id: 'chemicals',
      icon: Icons.science,
      color: Colors.red,
      name: 'Químicos',
      category: 'toxic',
      isTrash: false,
    ),
    GameObjectType(
      id: 'bulb',
      icon: Icons.lightbulb,
      color: Colors.red,
      name: 'Bombilla',
      category: 'electronics',
      isTrash: false,
    ),
  ];


  @override
  void initState() {
    super.initState();
    left = widget.initialX;
    _generateNewObject();
    if (!widget.isPaused) startFalling();
  }

  @override
  void didUpdateWidget(covariant FallingObject oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPaused != oldWidget.isPaused) {
      if (widget.isPaused) {
        // Pausa: detener el timer
        timer?.cancel();
        timer = null;
      } else {
        // Reanuda: iniciar de nuevo
        startFalling();
      }
    }
  }

  void _generateNewObject() {
    currentObject = gameObjects[random.nextInt(gameObjects.length)];
    top = -60;
  }

  void startFalling() {
    timer = Timer.periodic(const Duration(milliseconds: 50), (_) {
      if (!mounted || widget.isPaused) return;

      setState(() {
        top += 4;
        widget.onObjectCaught(currentObject.isTrash, left, top);

        final screenHeight = MediaQuery.of(context).size.height;
        if (top > screenHeight) {
          _generateNewObject();
          top = -60;
          left = random.nextDouble() * (MediaQuery.of(context).size.width - 60);
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: GestureDetector(
        onTap: () {
          if (!widget.isPaused) {
            widget.onObjectCaught(currentObject.isTrash, left, top);
            _generateNewObject();
            top = -60;
            left = random.nextDouble() * (MediaQuery.of(context).size.width - 60);
          }
        },
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: currentObject.color.withOpacity(0.9),
            shape: BoxShape.circle,
            border: Border.all(color: currentObject.color.withOpacity(0.7), width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            currentObject.icon,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class GameObjectType {
  final String id;
  final IconData icon;
  final Color color;
  final String name;
  final String category;
  final bool isTrash;

  GameObjectType({
    required this.id,
    required this.icon,
    required this.color,
    required this.name,
    required this.category,
    required this.isTrash,
  });
}
