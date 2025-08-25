import 'package:flutter/material.dart';

class TrashBin extends StatelessWidget {
  final double width;
  final String color;

  const TrashBin({super.key, required this.width, required this.color});

  @override
  Widget build(BuildContext context) {
    Color binColor = Colors.grey;
    if (color == "verde") binColor = Colors.green;
    if (color == "azul") binColor = Colors.blue;
    if (color == "negro") binColor = Colors.black;

    return Container(
      width: width,
      height: 80,
      decoration: BoxDecoration(
        color: binColor,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
