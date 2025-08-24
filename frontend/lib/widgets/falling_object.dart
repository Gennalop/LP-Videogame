import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class FallingObject extends StatefulWidget {
  final double initialX;
  final bool isPaused;
  final Function(bool isCorrect, double x, double y) onObjectCaught;

  const FallingObject({
    super.key,
    required this.initialX,
    this.isPaused = false,
    required this.onObjectCaught,
  });

  @override
  FallingObjectState createState() => FallingObjectState();
}

class FallingObjectState extends State<FallingObject> {
  double top = 0;
  double left = 0;
  late Timer timer;
  late GameObjectType currentObject;
  final Random random = Random();
  bool paused = false;
  bool caught = false;

  final List<GameObjectType> gameObjects = [
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
    paused = widget.isPaused;
    left = widget.initialX;
    _generateNewObject();
    _startFalling();
  }

  void _generateNewObject() {
    currentObject = gameObjects[random.nextInt(gameObjects.length)];
    top = -60;
    caught = false;
  }

  void _startFalling() {
    timer = Timer.periodic(const Duration(milliseconds: 50), (t) {
      if (!mounted || paused) return;

      setState(() {
        top += 4;
        final screenHeight = MediaQuery.of(context).size.height;

        if (!caught) {
          widget.onObjectCaught(currentObject.isTrash, left, top);
        }

        if (top > screenHeight) {
          _generateNewObject();
        }
      });
    });
  }

  void markCaught() {
    caught = true;
  }

  void moveLeft() {
    if (!paused && mounted && left > 0) {
      setState(() {
        left -= 30;
      });
    }
  }

  void moveRight() {
    final screenWidth = MediaQuery.of(context).size.width;
    if (!paused && mounted && left < screenWidth - 60) {
      setState(() {
        left += 30;
      });
    }
  }

  void setPaused(bool value) {
    setState(() {
      paused = value;
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: currentObject.color.withOpacity(0.9),
          shape: BoxShape.circle,
          border: Border.all(
            color: currentObject.color.withOpacity(0.7),
            width: 3,
          ),
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
