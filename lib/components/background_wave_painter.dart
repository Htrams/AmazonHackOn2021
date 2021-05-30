import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class BackgroundWavePainter extends CustomPainter {

  final double midHeight;

  BackgroundWavePainter({
    this.midHeight = 0.65
  });

  @override
  void paint(Canvas canvas, Size size) {
    // print('building with $midHeight');
    double height = size.height;
    double width = size.width;

    // Paint specifies the type of stroke/color/fill
    Paint paint1 = Paint();
    paint1.shader = ui.Gradient.linear(
        Offset(0, height * 0.5),
        Offset(0, height),
        <Color>[
          Colors.lightBlueAccent,
          Colors.blue.shade900
        ]);
    paint1.style = PaintingStyle.fill;

    // Path specifies the drawing path
    Path curve = Path();
    curve.moveTo(0, height * (midHeight-0.02));
    curve.quadraticBezierTo(width*0.12,height * (midHeight-0.04),width*0.333,height*midHeight);
    curve.quadraticBezierTo(width*0.5, height*(midHeight+0.03), width*0.666, height*midHeight);
    curve.quadraticBezierTo(width*0.88, height * (midHeight-0.04), width,height*(midHeight-0.02));
    curve.lineTo(width, height);
    curve.lineTo(0, height);
    canvas.drawPath(curve, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}