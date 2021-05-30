import 'package:flutter/material.dart';
class AppLogo extends StatelessWidget {

  final double size;
  final Color color;

  AppLogo({
    this.size = 100.0,
    this.color = const Color(0xFF90CAF9), //Colors.blue.shade200
});

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: 'appLogo',
        child: Icon(
          Icons.medical_services,
          size: size,
          color: color,
        )
    );
  }
}
