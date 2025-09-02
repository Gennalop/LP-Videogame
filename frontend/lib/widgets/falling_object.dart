import 'dart:async';
import 'package:flutter/material.dart';

class FallingObject extends StatefulWidget {
  final double initialX;
  final double speed;
  final String color;
  final String image; 
  final double width;
  final String? category;
  final Function(String objColor, double objX, double objY) onObjectCaught;

  const FallingObject({
    super.key,
    required this.initialX,
    required this.speed,
    required this.color,
    required this.image,
    required this.width,
    this.category,
    required this.onObjectCaught,
  });

  @override
  FallingObjectState createState() => FallingObjectState();
}

class FallingObjectState extends State<FallingObject> {
  double posY = 0;
  bool caught = false;
  bool paused = false;
  bool reachedGround = false;

  Timer? fallTimer;

  @override
  void initState() {
    super.initState();
    startFalling();
  }

  void startFalling() {
    fallTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (!paused && !caught && !reachedGround) {
        setState(() => posY += widget.speed);

        widget.onObjectCaught(widget.color, widget.initialX, posY);

        final screenHeight = MediaQuery.of(context).size.height;
        final groundLevel = screenHeight - 80;

        if (posY >= groundLevel) {
          setState(() {
            posY = groundLevel;
            reachedGround = true;
          });
          timer.cancel();
        }
      }
    });
  }

  void setPaused(bool value) => setState(() => paused = value);
  void markCaught() {
    setState(() {
      caught = true;
      fallTimer?.cancel();
    });
  }

  @override
  void dispose() {
    fallTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (caught) return Container();
    return Positioned(
      top: posY,
      left: widget.initialX,
      child: Image.asset(widget.image, width: widget.width, height: widget.width),
    );
  }
}
