import 'package:flutter/material.dart';
import 'package:planet_simulation_flutter/src/central_star_data.dart';
import 'package:planet_simulation_flutter/src/parameter.dart';

class CentralStar extends StatelessWidget {
  late CentralStarData data;
  late Parameter parameter;

  CentralStar({required data, required parameter});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: CentralStarPainter());
  }
}

class CentralStarPainter extends CustomPainter {
  late CentralStarData data;
  late Parameter parameter;

  @override
  void paint(Canvas canvas, Size size) {
    Offset centralStarLocation = Offset(data.position.x, data.position.y);

    Paint centralStarPaint =
        Paint()
          ..color = data.color
          ..style = PaintingStyle.fill;

    double factor =
        data.diameter / parameter.astronomicalUnit * parameter.windowSize;

    canvas.drawCircle(centralStarLocation, factor, centralStarPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
