import 'dart:math';
import 'package:flutter/material.dart';

class Star extends CustomPainter {
  double windowSize = 0;
  double starSize = 0;
  double positionX = 0;
  double positionY = 0;
  Color starColor;
  Paint starPaint = Paint();

  Star({
    required this.windowSize,
    required this.starSize,
    required this.starColor,
  }) {
    Random random = Random();
    positionX = random.nextDouble() * windowSize;
    positionY = random.nextDouble() * windowSize;
    starPaint =
        Paint()
          ..color = starColor
          ..style = PaintingStyle.fill
          ..strokeWidth = 1;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final points = 6;
    final angle = (pi * 2) / points;

    for (int i = 0; i < points * 2; i++) {
      final currentAngle = angle * i;
      final currentRadius = i.isEven ? starSize : starSize / 2;
      final x = positionX + currentRadius * cos(currentAngle);
      final y = positionY + currentRadius * sin(currentAngle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.close();
    canvas.drawPath(path, starPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
