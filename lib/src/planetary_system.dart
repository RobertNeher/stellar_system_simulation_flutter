import 'package:flutter/material.dart';

import 'package:planet_simulation_flutter/src/central_star.dart';
import 'package:planet_simulation_flutter/src/parameter.dart';
import 'package:planet_simulation_flutter/src/planet.dart';

class PlanetarySystem extends CustomPainter {
  Parameter parameter;
  CentralStar centralStar;
  List<Planet> planets = [];
  int spaceTime = 0;
  double maxSpaceSize = 0.0;
  double radius = 0.0;

  PlanetarySystem({
    required this.parameter,
    required this.centralStar,
    required this.planets,
    required this.spaceTime,
  }) {
    maxSpaceSize = parameter.scaleFactor * parameter.astronomicalUnit;
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

    radius = (centralStar.diameter / maxSpaceSize) * parameter.windowSize / 2;
    print("CentalStar: ${radius * parameter.windowSize}");

    canvas.drawCircle(centralStarLocation, radius, centralStarPaint);

    for (Planet planet in planets) {
      Offset planetLocation = Offset(
        (planet.position.x * parameter.astronomicalUnit / maxSpaceSize) *
            parameter.windowSize,
        (planet.position.y * parameter.astronomicalUnit / maxSpaceSize) *
            parameter.windowSize,
      );
      Paint planetPaint =
          Paint()
            ..color = planet.color
            ..style = PaintingStyle.fill;

      radius = (planet.diameter / maxSpaceSize) * parameter.windowSize / 2;

      print("Planet ${planet.name}: ${radius}");

      // canvas.drawCircle(
      //   planetLocation,
      //   radius,
      //   planetPaint,
      // );
    }
  }

  @override
  bool shouldRepaint(oldDelegate) => false;
}
