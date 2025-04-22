import 'dart:async';
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
  double stellarSystemTime = 0;
  Timer? timer;
  @override
  void initState() {
    // widget.parameter.timeStep.toDouble();
    timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    stellarSystemTime += widget.parameter.timeStep;
    return Center(
      child: CustomPaint(
        painter: PlanetarySystemPainter(
            parameter: widget.parameter,
            centralStar: widget.centralStar,
            planets: widget.planets,
            stellarSystemTime: stellarSystemTime),
      ),
    );
  }
}

class PlanetarySystemPainter extends CustomPainter {
  Parameter? parameter;
  CentralStar centralStar;
  List<Planet> planets = [];
  double centralStarDrawingRadius = 0;
  double stellarSystemTime = 0;

  PlanetarySystemPainter(
      {required this.parameter,
      required this.centralStar,
      required this.planets,
      required this.stellarSystemTime}) {
    centralStarDrawingRadius = centralStar.diameter /
        (2 * parameter!.astronomicalUnit) *
        parameter!.windowSize *
        centralStar.sizeFactor;
  }
  @override
  void paint(Canvas canvas, Size size) {
    Offset centralStarLocation = Offset(
      centralStar.position.x,
      centralStar.position.y,
    );
    Paint centralStarPaint = Paint()
      ..color = centralStar.color
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      centralStarLocation,
      centralStarDrawingRadius,
      centralStarPaint,
    );

    for (Planet planet in planets) {
      double theta =
          2 * pi * stellarSystemTime / (planet.period * parameter!.timeStep);

      planet.position.x = parameter!.windowSize *
          (planet.position.x / 2) *
          cos(theta) /
          parameter!.astronomicalUnit;
      planet.position.y = parameter!.windowSize *
          (planet.diameter / 2) *
          sin(theta) /
          parameter!.astronomicalUnit;

      Offset planetLocation = Offset(
          (parameter!.windowSize *
                      (planet.position.x *
                          parameter!.astronomicalUnit /
                          parameter!.totalSizeFactor *
                          parameter!.astronomicalUnit)) /
                  parameter!.astronomicalUnit +
              centralStarDrawingRadius,
          (parameter!.windowSize *
                  (planet.position.y *
                      parameter!.astronomicalUnit /
                      parameter!.totalSizeFactor *
                      parameter!.astronomicalUnit)) /
              parameter!.astronomicalUnit);

      Paint planetPaint = Paint()
        ..color = planet.color
        ..style = PaintingStyle.fill;
      double radius = planet.diameter /
          parameter!.totalSizeFactor *
          parameter!.astronomicalUnit *
          parameter!.scaleFactor;

      print(
          "${radius}: ${planetLocation.dx / parameter!.astronomicalUnit}/${planetLocation.dy / parameter!.astronomicalUnit}");
      canvas.drawCircle(
          planetLocation / parameter!.astronomicalUnit, radius, planetPaint);
    }
  }

  @override
  bool shouldRepaint(oldDelegate) => false;
}
