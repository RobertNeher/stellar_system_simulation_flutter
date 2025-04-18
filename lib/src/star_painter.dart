import 'dart:math';
import 'package:flutter/material.dart';

class StarPainter extends CustomPainter {
  final Size starSize;
  final Color starColor;
  final int edges;

  StarPainter({
    required this.starSize,
    required this.starColor,
    required this.edges});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = starColor
          ..style = PaintingStyle.fill;

    final path = Path();
    final center = Offset(starSize.width / 2, starSize.height / 2);
    final outerRadius = starSize.width;
    final innerRadius =
        outerRadius * 0.382; // Golden ratio for a classic star look

    double angle = -pi / 2;
    double step = pi / edges; // Angle between points

    path.moveTo(
      center.dx + outerRadius * cos(angle),
      center.dy + outerRadius * sin(angle),
    );

    for (int i = 0; i < edges; i++) {
      angle += step;
      path.lineTo(
        center.dx + innerRadius * cos(angle),
        center.dy + innerRadius * sin(angle),
      );
      angle += step;
      path.lineTo(
        center.dx + outerRadius * cos(angle),
        center.dy + outerRadius * sin(angle),
      );
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
