import 'package:flutter/material.dart';
import 'dart:async';

class FallingObject extends StatefulWidget {
  final VoidCallback onCatch;

  const FallingObject({super.key, required this.onCatch});

  @override
  _FallingObjectState createState() => _FallingObjectState();
}

class _FallingObjectState extends State<FallingObject> {
  double top = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startFalling();
  }

  void startFalling() {
    timer = Timer.periodic(const Duration(milliseconds: 50), (t) {
      setState(() {
        top += 5;
        if (top > 500) {
          top = 0;
          widget.onCatch();
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
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 50),
      top: top,
      left: MediaQuery.of(context).size.width / 2 - 25,
      child: const Icon(Icons.delete, size: 50, color: Colors.red),
    );
  }
}
