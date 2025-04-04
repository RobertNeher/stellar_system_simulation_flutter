import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:planet_simulation_flutter/src/planet.dart';
import 'package:planet_simulation_flutter/src/central_star.dart';
import 'package:planet_simulation_flutter/src/parameter.dart';
import 'package:vector_math/vector_math.dart' as vector;

void main() {
  runApp(const PlanetSimulationApp());
}

class PlanetSimulationApp extends StatelessWidget {
  const PlanetSimulationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: PlanetSimulation());
  }
}

class PlanetSimulation extends StatefulWidget {
  const PlanetSimulation({super.key});

  @override
  _PlanetSimulationState createState() => _PlanetSimulationState();
}

class _PlanetSimulationState extends State<PlanetSimulation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Planet> planets = [];
  Parameter? params;
  CentralStar? centralStar;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 16),
      vsync: this,
    )..repeat();
    _loadData();
  }

  Future<void> _loadData() async {
    final String data = await rootBundle.loadString('parameter.json');
    final Map<String, dynamic> jsonData = json.decode(data);
    setState(() {
      print("Load data...");
      params = Parameter.fromJson(jsonData['parameter']);
      print(params);
      centralStar = CentralStar.fromJson(jsonData['centralStar']);
      print(centralStar);
      planets =
          (jsonData['planets'] as List)
              .map((planet) => Planet.fromJson(planet))
              .toList();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: params?.backgroundColor,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          _updatePlanets();
          return Stack(
            children: [
              Positioned(
                left: params!.centerX - centralStar!.diameter / 2,
                top: params!.centerY - centralStar!.diameter / 2,
                child: Container(
                  width: centralStar!.diameter,
                  height: centralStar!.diameter,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: centralStar!.color,
                  ),
                ),
              ),
              ...planets.map(
                (planet) => Positioned(
                  left:
                      planet.position.x + params!.centerX - planet.diameter / 2,
                  top:
                      planet.position.y + params!.centerY - planet.diameter / 2,
                  child: Container(
                    width: planet.diameter,
                    height: planet.diameter,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: planet.color,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _updatePlanets() {
    for (var planet in planets) {
      final distanceVector = vector.Vector2(
        (params!.centerX - planet.position.x),
        (params!.centerY - planet.position.y),
      );
      final distance = distanceVector.length;

      if (distance > 0) {
        final force =
            params!.gravityConstant *
            planet.mass *
            centralStar!.mass /
            pow(distance, 2);
        final acceleration = distanceVector.normalized() * force / planet.mass;

        planet.velocity += acceleration;
        planet.position += planet.velocity;
      }
    }
  }
}
