import 'dart:math';

import 'package:flutter/material.dart';
import 'package:planet_simulation_flutter/src/parameter.dart';

Widget stars(Parameter parameter) {
  Stack starsInSpace = Stack();

  for (int i = 0; i < parameter.starCount; i++) {
    Positioned star = Positioned(
      left: Random().nextDouble() * parameter.windowSize,
      top: Random().nextDouble() * parameter.windowSize,
      child: CustomPaint(
        size: Size(3, 3),
        painter: StarPainter(starColor: parameter.starColor),
      ),
    );
    print("oder hier?");
    starsInSpace.children.add(star);
  }
  return starsInSpace;
}

class StarPainter extends CustomPainter {
  Color starColor = Colors.amberAccent;

  StarPainter({required this.starColor});

  @override
  void paint(Canvas canvas, Size size) {
    Paint starPaint =
        Paint()
          ..color = starColor
          ..style = PaintingStyle.fill;

    Path path = Path();
    double xCenter = size.width / 2;
    double yCenter = size.height / 2;
    double radius = min(xCenter, yCenter);

    // Berechnung der Punkte des Sterns
    List<Offset> points = [];
    for (int i = 0; i < 10; i++) {
      double angle = i * pi / 5;
      double x = xCenter + (i % 2 == 0 ? radius : radius / 2) * cos(angle);
      double y = yCenter + (i % 2 == 0 ? radius : radius / 2) * sin(angle);
      points.add(Offset(x, y));
    }

    // Pfad erstellen
    path.moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    path.close();

    // Pfad zeichnen
    canvas.drawPath(path, starPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
