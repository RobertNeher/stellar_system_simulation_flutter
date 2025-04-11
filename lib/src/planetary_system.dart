import 'package:flutter/material.dart';

import 'package:planet_simulation_flutter/src/central_star_data.dart';
import 'package:planet_simulation_flutter/src/parameter.dart';
import 'package:planet_simulation_flutter/src/planet.dart';

class PlanetarySystem extends StatefulWidget {
  Parameter parameter;
  CentralStar centralStar;
  List<Planet> planets = [];
  int spaceTime = 0;
  double sizeFactor = 0.0;
  double planetarySystemSize = 0.0;

  PlanetarySystem({
    super.key,
    required this.parameter,
    required this.centralStar,
    required this.planets,
    required this.spaceTime,
    required this.sizeFactor,
  }) {
    planetarySystemSize = sizeFactor * parameter.astronomicalUnit;
  }

  @override
  State<PlanetarySystem> createState() => _PlanetarySystemState();
}

class _PlanetarySystemState extends State<PlanetarySystem> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

  // @override
  // void paint(Canvas canvas, Size size) {

  //   for (Planet planet in planets) {
  //     // Planet planet = planets[0];
  //     Offset planetLocation = Offset(
  //       parameter.windowSize *
  //           (planet.position.x *
  //               parameter.astronomicalUnit /
  //               this.planetarySystemSize),
  //       parameter.windowSize *
  //           (planet.position.y *
  //               parameter.astronomicalUnit /
  //               this.planetarySystemSize),
  //     );
  //     Paint planetPaint =
  //         Paint()
  //           ..color = planet.color
  //           ..style = PaintingStyle.fill;
  //     factor = planet.diameter / planetarySystemSize * parameter.scaleFactor;

  //     canvas.drawCircle(planetLocation, factor, planetPaint);
  //   }
  // }

//   @override
//   bool shouldRepaint(oldDelegate) => false;
// }
