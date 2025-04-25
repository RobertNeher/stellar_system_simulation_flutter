import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:planet_simulation_flutter/src/parameter.dart';
import 'package:planet_simulation_flutter/src/planet.dart';

class PlanetarySystem extends StatefulWidget {
  final Parameter parameter;
  List<Planet> planets = [];
  final double sizeFactor = 0.0;
  final double centralStarDrawingRadius = 0;

  PlanetarySystem({super.key, required this.parameter, required this.planets});

  @override
  State<PlanetarySystem> createState() => _PlanetarySystemState();
}

class _PlanetarySystemState extends State<PlanetarySystem> {
  double stellarSystemTime = 0;
  Timer? timer;
  @override
  void initState() {
    timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      setState(() {
        stellarSystemTime += widget.parameter.timeStep;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        painter: PlanetarySystemPainter(
          parameter: widget.parameter,
          planets: widget.planets,
          stellarSystemTime: stellarSystemTime,
        ),
      ),
    );
  }
}

class PlanetarySystemPainter extends CustomPainter {
  Parameter? parameter;
  List<Planet> planets = [];
  double centralStarDrawingRadius = 0;
  double stellarSystemTime = 0;

  PlanetarySystemPainter({
    required this.parameter,
    required this.planets,
    required this.stellarSystemTime,
  });
  @override
  void paint(Canvas canvas, Size size) {
    for (Planet planet in planets) {
      double theta =
          2 * pi * stellarSystemTime / (planet.period * parameter!.timeStep);

      planet.position.x =
          (parameter!.windowSize *
              (planet.position.x / 2) *
              cos(theta) /
              parameter!.astronomicalUnit);

      planet.position.y =
          (parameter!.windowSize *
              (planet.position.y / 2) *
              sin(theta) /
              parameter!.astronomicalUnit) /
          5;

      Offset planetLocation = Offset(planet.position.x, planet.position.y);
      Paint planetPaint =
          Paint()
            ..color = planet.color
            ..style = PaintingStyle.fill;
      double radius =
          planet.diameter /
          (parameter!.totalSizeFactor * parameter!.astronomicalUnit) *
          parameter!.scaleFactor;
      print(
        "x (${planet.name}/$theta: $radius - ${planet.position.x}/${planet.position.y}",
      );

      canvas.drawCircle(planetLocation, radius, planetPaint);
    }
  }

  @override
  bool shouldRepaint(oldDelegate) => true;
}
