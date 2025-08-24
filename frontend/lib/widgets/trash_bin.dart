import 'package:flutter/material.dart';

class TrashBin extends StatelessWidget {
  final double width; // Añadido

  const TrashBin({super.key, this.width = 120}); // valor por defecto

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, // usar ancho
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Icon(Icons.delete, color: Colors.white, size: 40),
      ),
    );
  }
}

