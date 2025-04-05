import 'dart:math';
import 'package:flutter/material.dart';
import 'package:planet_simulation_flutter/src/helper.dart';

class PlanetarySystem extends CustomPainter {
  Map<String, dynamic> parameter = {};
  Map<String, dynamic> centralStar = {};
  // List<Map<String, dynamic>> planets = [];
  int spaceTime = 0;
  double factor = 0.0;

  PlanetarySystem({
    required Map<String, dynamic> this.centralStar,
    // required List<Map<String, dynamic>> this.planets,
    required Map<String, dynamic> this.parameter,
    required int this.spaceTime,
  }) {
    this.factor = parameter['windowWidth'] / parameter['astronomicalUnit'];
  }

  @override
  void paint(Canvas canvas, Size size) {
    Offset centralStarLocation = Offset(
      centralStar['centerX'],
      centralStar['centerY'],
    );
    Paint centralStarPaint =
        Paint()
          ..color = colorFromString(centralStar['color'])
          ..style = PaintingStyle.fill;
    print(centralStar['diameter'] / 2 * factor);
    canvas.drawCircle(
      centralStarLocation,
      centralStar['diameter'] / 2 * factor,
      centralStarPaint,
    );
  }

  @override
  bool shouldRepaint(oldDelegate) => false;
}
