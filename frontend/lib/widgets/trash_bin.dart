import 'package:flutter/material.dart';

class TrashBin extends StatelessWidget {
  final double width;
  final double height;
  final String color;

  const TrashBin({super.key, required this.width, required this.height, required this.color});

  @override
  Widget build(BuildContext context) {
    Color binColor = Colors.grey;
    if (color == "verde") binColor = Colors.green;
    if (color == "azul") binColor = Colors.blue;
    if (color == "negro") binColor = const Color.fromARGB(255, 56, 56, 56);

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Cuerpo del tacho
          Positioned(
            top: height * 0.2, // 20% del alto total
            child: Container(
              width: width * 0.9,
              height: height * 0.8, // 80% del alto total
              decoration: BoxDecoration(
                color: binColor,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(16),
                ),
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
            ),
          ),
          // Tapa del tacho
          Container(
            width: width,
            height: height * 0.2, // 20% del alto total
            decoration: BoxDecoration(
              color: binColor,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
            ),
          ),
        ],
      ),
    );

  }
}
