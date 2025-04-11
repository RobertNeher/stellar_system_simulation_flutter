import 'dart:math';
import 'package:flutter/material.dart';

class Star extends CustomPainter {
  double size = 0;
  double positionX = 0;
  double positionY = 0;
  Color color;

  Star({required this.size, required this.color}) {
    Random random = Random();
    positionX = random.nextDouble() * size;
    positionY = random.nextDouble() * size;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = positionX; //size.width / 2;
    final centerY = positionY; //size.height / 2;
    final radius = this.size / 2;

    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;

    final path = Path();
    final points = 6;
    final angle = (pi * 2) / points;

    for (int i = 0; i < points * 2; i++) {
      final currentAngle = angle * i;
      final currentRadius = i.isEven ? radius : radius / 2;
      final x = centerX + currentRadius * cos(currentAngle);
      final y = centerY + currentRadius * sin(currentAngle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
