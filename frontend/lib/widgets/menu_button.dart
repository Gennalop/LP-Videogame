import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final String text;
  final Widget page;
  final Color backgroundColor;
  final Color textColor;
  final IconData icon;

  const MenuButton({
    super.key,
    required this.text,
    required this.page,
    required this.backgroundColor,
    required this.icon,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 40),
      child: ElevatedButton.icon(
        icon: Icon(icon, color: textColor),
        label: Text(
          text,
          style: TextStyle(fontSize: 18, color: textColor),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          minimumSize: const Size(double.infinity, 55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => page),
          );
        },
      ),
    );
  }
}
