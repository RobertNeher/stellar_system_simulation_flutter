import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    super.initState();
  }

  Future<void> _loadSettings() async {
    String jsonData = await rootBundle.loadString('settings.json');
    // String settings = File('assets/settings.json').readAsStringSync();
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
          print(settings['parameter']);
          print(settings['centralStar']);
          print(settings['planets']);
          return Center(
            child: Scaffold(
              backgroundColor: colorFromString(
                settings['parameter']['backgroundColor'],
              ),
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  widget.appBarTitle,
                  // textDirection: TextDirection.ltr,
                  style: TextStyle(
                    color: complimentaryColor(
                      settings['parameter']['backgroundColor'],
                    ),
                    letterSpacing: 1,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              body: Center(
                child: CustomPaint(
                  painter: PlanetarySystem(
                    centralStar: settings['centralStar'],
                    // planets: settings['planets'],
                    parameter: settings['parameter'],
                    spaceTime: 0,
                  ),
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
