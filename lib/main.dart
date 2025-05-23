import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:planet_simulation_flutter/src/central_star.dart';
import 'package:planet_simulation_flutter/src/central_star_data.dart';
import 'package:planet_simulation_flutter/src/parameter.dart';
import 'package:planet_simulation_flutter/src/planet.dart';
// import 'package:planet_simulation_flutter/src/planetary_system.dart';
import 'package:planet_simulation_flutter/src/helper.dart';
import 'package:planet_simulation_flutter/src/planetary_system.dart';
import 'package:planet_simulation_flutter/src/space_background.dart';
import 'package:planet_simulation_flutter/src/space_background_data.dart';

void main() => runApp(
      const MaterialApp(
        home: PlanetarySystemSimulationApp(),
        debugShowCheckedModeBanner: false,
      ),
    );

class PlanetarySystemSimulationApp extends StatefulWidget {
  const PlanetarySystemSimulationApp({super.key});
  final String appBarTitle = 'Planetary System Simulation';
  @override
  State<PlanetarySystemSimulationApp> createState() =>
      _PlanetarySystemSimulationAppState();
}

class _PlanetarySystemSimulationAppState
    extends State<PlanetarySystemSimulationApp> with TickerProviderStateMixin {
  Map<String, dynamic> settings = {};

  @override
  void initState() {
    _loadSettings();

    super.initState();
  }

  Future<void> _loadSettings() async {
    String jsonData = await rootBundle.loadString('settings.json');
    settings = json.decode(jsonData);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _loadSettings(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
              strokeWidth: 5,
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Parameter parameter = Parameter.fromJson(settings['parameter']);
          double windowSize =
              (parameter.windowSize > MediaQuery.of(context).size.width
                      ? parameter.windowSize
                      : MediaQuery.of(context).size.width.toDouble())
                  .toDouble();
          CentralStarData centralStarData = CentralStarData.fromJson(
            settings['centralStar'],
          );
          SpaceBackgroundData spaceBackgroundData =
              SpaceBackgroundData.fromJson(settings['spaceBackground']);
          Stack stellarSystem = Stack(
            alignment: Alignment.center,
            children: spaceBackground(windowSize, spaceBackgroundData),
          );
          List<Planet> planets = [];

          for (Map<String, dynamic> planet in settings['planets']) {
            planets.add(Planet.fromJson(planet, parameter.astronomicalUnit));
          }

          stellarSystem.children.add(
            CentralStar(centralStarData, parameter),
            // PlanetarySystem(parameter: parameter, planets: planets),
          );

          return Center(
            child: Scaffold(
              backgroundColor: spaceBackgroundData.backgroundColor,
              appBar: AppBar(
                backgroundColor: spaceBackgroundData.backgroundColor,
                centerTitle: true,
                title: Text(
                  widget.appBarTitle,
                  style: TextStyle(
                    color: complimentaryColor(
                      spaceBackgroundData.backgroundColor,
                    ),
                    letterSpacing: 3,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              body: stellarSystem,
            ),
          );
        } else {
          return const Text(
            'Something went wrong!',
            style: TextStyle(
              // fontFamily: 'Railway',
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.red,
            ),
          );
        }
      },
    );
  }
}
