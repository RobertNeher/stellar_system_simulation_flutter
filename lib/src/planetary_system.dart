import 'package:flutter/material.dart';

import 'package:planet_simulation_flutter/src/central_star.dart';
import 'package:planet_simulation_flutter/src/parameter.dart';
import 'package:planet_simulation_flutter/src/planet.dart';

class PlanetarySystem extends CustomPainter {
  Parameter parameter;
  CentralStar centralStar;
  List<Planet> planets = [];
  int spaceTime = 0;
  double factor = 0.0;

  PlanetarySystem({
    required this.parameter,
    required this.centralStar,
    required this.planets,
    required this.spaceTime,
    required this.factor,
  }) {
    factor =
        parameter.scaleFactor *
        parameter.astronomicalUnit /
        centralStar.diameter;

    print(factor); // TODO: Remove print
    print(centralStar.size); // TODO: Remove print
  }

  @override
  void paint(Canvas canvas, Size size) {
    Offset centralStarLocation = Offset(
      centralStar.position.x,
      centralStar.position.y,
    );
    Paint centralStarPaint =
        Paint()
          ..color = centralStar.color
          ..style = PaintingStyle.fill;

    canvas.drawCircle(
      centralStarLocation,
      centralStar.size / parameter.scaleFactor,
      centralStarPaint,
    );

    for (Planet planet in planets) {
      Offset planetLocation = Offset(
        parameter.windowWidth * planet.position.x,
        parameter.windowWidth * planet.position.y,
      );
      Paint planetPaint =
          Paint()
            ..color = planet.color
            ..style = PaintingStyle.fill;

      canvas.drawCircle(
        planetLocation,
        parameter.windowWidth * planet.diameter / (2 * parameter.scaleFactor),
        planetPaint,
      );
    }
  }

  @override
  bool shouldRepaint(oldDelegate) => false;
}
