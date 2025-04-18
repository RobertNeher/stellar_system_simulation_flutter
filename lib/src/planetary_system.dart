import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vector;

import 'package:planet_simulation_flutter/src/central_star.dart';
import 'package:planet_simulation_flutter/src/parameter.dart';
import 'package:planet_simulation_flutter/src/planet.dart';

class PlanetarySystem extends StatefulWidget {
  Parameter parameter;
  CentralStar centralStar;
  List<Planet> planets = [];
  int spaceTime = 0;
  double sizeFactor = 0.0;
  double planetarySystemSize = 0.0;
  double centralStarDrawingRadius = 0;

  PlanetarySystem({
    Key? key,
    required parameter,
    required centralStar,
    required planets,
    required spaceTime,
    required sizeFactor,
    required planetarySystemSize,
    required centralStarDrawingRadius,
  }) : super(key: key);
  @override
  State<PlanetarySystem> createState() => _PlanetarySystemState();
}

class _PlanetarySystemState extends State<PlanetarySystem> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        painter: PlanetarySystemPainter(
          parameter: widget.parameter,
          centralStar: widget.centralStar,
          planets: widget.planets,
          spaceTime: widget.spaceTime,
          sizeFactor: widget.sizeFactor,
        ),
      ),
    );
  }
}

class PlanetarySystemPainter extends CustomPainter {
  Parameter? parameter;
  CentralStar centralStar;
  List<Planet> planets = [];
  int spaceTime = 0;
  double sizeFactor = 0.0;
  double planetarySystemSize = 0.0;
  double centralStarDrawingRadius = 0;

  PlanetarySystemPainter({
    required this.parameter,
    required this.centralStar,
    required this.planets,
    required this.spaceTime,
    required this.sizeFactor,
  }) {
    planetarySystemSize = this.sizeFactor * parameter!.astronomicalUnit;
    centralStarDrawingRadius =
        centralStar.diameter /
        (2 * parameter!.astronomicalUnit) *
        parameter!.windowSize *
        centralStar.sizeFactor;
  }

  vector.Vector2 attraction(Planet before, Planet next) {
    double distance = sqrt(
      pow((next.position.x - before.position.x), 2) +
          pow((next.position.y - before.position.y), 2),
    );
    double force = parameter!.gravityConstant * before.mass / pow(distance, 2);
    double theta = atan2(
      (next.position.y - before.position.y),
      (next.position.x - before.position.x),
    );
    return vector.Vector2((cos(theta) * force), sin(theta) * force);
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
      centralStarDrawingRadius,
      centralStarPaint,
    );

    for (Planet planet in planets) {
      Offset planetLocation = Offset(
        (parameter!.windowSize *
                (planet.position.x *
                    parameter!.astronomicalUnit /
                    this.planetarySystemSize)) +
            this.centralStarDrawingRadius,
        parameter!.windowSize *
            (planet.position.y *
                parameter!.astronomicalUnit /
                this.planetarySystemSize),
      );
      Paint planetPaint =
          Paint()
            ..color = planet.color
            ..style = PaintingStyle.fill;
      double radius =
          planet.diameter / planetarySystemSize * parameter!.scaleFactor;

      canvas.drawCircle(planetLocation, radius, planetPaint);
    }
  }

  @override
  bool shouldRepaint(oldDelegate) => false;
}
