import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:planet_simulation_flutter/src/central_star.dart';
import 'package:planet_simulation_flutter/src/parameter.dart';
import 'package:planet_simulation_flutter/src/planet.dart';
import 'package:planet_simulation_flutter/src/planetary_system.dart';
import 'package:planet_simulation_flutter/src/helper.dart';

void main() => runApp(
  MaterialApp(
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
    extends State<PlanetarySystemSimulationApp>
    with TickerProviderStateMixin {
  Map<String, dynamic> settings = {};

  @override
  void initState() {
    _loadSettings();

    Timer timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {});
    });
    super.initState();
  }

  Future<void> _loadSettings() async {
    String jsonData = await rootBundle.loadString('settings.json');
    settings = json.decode(jsonData);
  }

  @override
  void dispose() {
    super.dispose();
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
          List<Planet> planets = [];
          Parameter parameter = Parameter.fromJson(settings['parameter']);
          CentralStar centralStar = CentralStar.fromJson(
            settings['centralStar'],
          );

          for (Map<String, dynamic> planet in settings['planets']) {
            planets.add(Planet.fromJson(planet));
          }

          return Center(
            child: Scaffold(
              backgroundColor: parameter.backgroundColor,
              appBar: AppBar(
                backgroundColor: parameter.backgroundColor,
                centerTitle: true,
                title: Text(
                  widget.appBarTitle,
                  style: TextStyle(
                    color: complimentaryColor(parameter.backgroundColor),
                    letterSpacing: 3,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              body: Center(
                child: PlanetarySystem(
                  centralStar: centralStar,
                  planets: planets,
                  parameter: parameter,
                  spaceTime: 0,
                  sizeFactor: 32,
                ),
              ),
            ),
          );
        } else {
          return Text(
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
