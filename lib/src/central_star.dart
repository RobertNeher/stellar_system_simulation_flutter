import 'package:flutter/material.dart';
import 'package:planet_simulation_flutter/src/parameter.dart';

import 'package:planet_simulation_flutter/src/central_star_data.dart';

class CentralStarPainter extends CustomPainter {
  late Parameter parameter;
  late CentralStarData centralStarData;
  double centralStarDrawingRadius = 0;

  CentralStarPainter({required this.parameter, required this.centralStarData}) {
    centralStarDrawingRadius = centralStarData.diameter /
        (2 * parameter!.astronomicalUnit) *
        parameter.windowSize *
        centralStarData.sizeFactor;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Offset centralStarLocation = Offset(
      centralStarData.position.x,
      centralStarData.position.y,
    );
    Paint centralStarPaint = Paint()
      ..color = centralStarData.color
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      centralStarLocation,
      centralStarDrawingRadius,
      centralStarPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

Widget CentralStar(CentralStarData centralStarData, Parameter parameter) {
  return CustomPaint(
    painter: CentralStarPainter(
        parameter: parameter, centralStarData: centralStarData),
  );
}
