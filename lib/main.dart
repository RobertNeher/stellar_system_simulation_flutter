import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:planet_simulation_flutter/space_background.dart';
import 'package:planet_simulation_flutter/src/central_star.dart';
import 'package:planet_simulation_flutter/src/central_star_data.dart';
import 'package:planet_simulation_flutter/src/parameter.dart';
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
              body: Stack(
                alignment: Alignment.center,
                children: [
                  SpaceBackground(parameter: parameter),
                  CentralStar(
                    data: CentralStarData.fromJson(settings['centralStar']),
                    parameter: Parameter.fromJson(settings['parameter']),
                  ),
                ],
              )
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
