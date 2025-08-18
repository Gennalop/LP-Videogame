import 'package:flutter/material.dart';

class TrashBin extends StatelessWidget {
  const TrashBin({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.delete_outline,
      size: 80,
      color: Colors.black,
    );
  }
}
