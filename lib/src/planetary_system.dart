import 'package:flutter/material.dart';

import 'package:planet_simulation_flutter/src/central_star.dart';
import 'package:planet_simulation_flutter/src/parameter.dart';
import 'package:planet_simulation_flutter/src/planet.dart';

class PlanetarySystem extends CustomPainter {
  Parameter parameter;
  CentralStar centralStar;
  List<Planet> planets = [];
  int spaceTime = 0;
  double sizeFactor = 0.0;
  double planetarySystemSize = 0.0;

  PlanetarySystem({
    required this.parameter,
    required this.centralStar,
    required this.planets,
    required this.spaceTime,
    required this.sizeFactor,
  }) {
    this.planetarySystemSize = this.sizeFactor * parameter.astronomicalUnit;
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

    double factor =
        centralStar.diameter /
        parameter.astronomicalUnit *
        parameter.windowSize;

    canvas.drawCircle(centralStarLocation, factor, centralStarPaint);

    for (Planet planet in planets) {
      // Planet planet = planets[0];
      Offset planetLocation = Offset(
        parameter.windowSize *
            (planet.position.x *
                parameter.astronomicalUnit /
                this.planetarySystemSize),
        parameter.windowSize *
            (planet.position.y *
                parameter.astronomicalUnit /
                this.planetarySystemSize),
      );
      Paint planetPaint =
          Paint()
            ..color = planet.color
            ..style = PaintingStyle.fill;
      factor = planet.diameter / planetarySystemSize * parameter.scaleFactor;

      canvas.drawCircle(planetLocation, factor, planetPaint);
    }
  }

  @override
  bool shouldRepaint(oldDelegate) => false;
}
