import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vector;

import 'package:planet_simulation_flutter/src/central_star.dart';
import 'package:planet_simulation_flutter/src/parameter.dart';
import 'package:planet_simulation_flutter/src/planet.dart';

class PlanetarySystem extends StatefulWidget {
  late final Parameter parameter;
  late final CentralStar centralStar;
  late List<Planet> planets = [];
  final double sizeFactor = 0.0;
  final double centralStarDrawingRadius = 0;

  PlanetarySystem({
    super.key,
    required this.parameter,
    required this.centralStar,
    required this.planets,
  });

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
        ),
      ),
    );
  }
}

class PlanetarySystemPainter extends CustomPainter {
  Parameter? parameter;
  CentralStar centralStar;
  List<Planet> planets = [];
  double planetarySystemSize = 0;
  double centralStarDrawingRadius = 0;

  PlanetarySystemPainter({
    required this.parameter,
    required this.centralStar,
    required this.planets,
  }) {
    planetarySystemSize =
        parameter!.totalSizeFactor * parameter!.astronomicalUnit;
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
                    planetarySystemSize)) +
            centralStarDrawingRadius,
        parameter!.windowSize *
            (planet.position.y *
                parameter!.astronomicalUnit /
                planetarySystemSize),
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
