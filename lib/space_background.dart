import 'package:flutter/material.dart';

import 'package:planet_simulation_flutter/src/parameter.dart';
import 'package:planet_simulation_flutter/src/star.dart';

class SpaceBackground extends StatefulWidget {
  final Parameter parameter;

  const SpaceBackground({super.key, required this.parameter});

  @override
  State<SpaceBackground> createState() => _SpaceBackgroundState();
}

class _SpaceBackgroundState extends State<SpaceBackground> {
  Size size = Size.zero;
  List<Widget> stars = [];

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    widget.parameter.windowSize = size.width.round();

    for (int i = 0; i < widget.parameter.maxStars; i++) {
      Star star = Star(color: widget.parameter.starColor, size: 6);
      stars.add(
        Positioned(
          top: star.positionX + 3,
          left: star.positionY + 3,
          child: CustomPaint(painter: star),
        ),
      );
    }
    Stack space = Stack(children: stars);

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: widget.parameter.windowSize.toDouble(),
          width: widget.parameter.windowSize.toDouble(),
          color: widget.parameter.backgroundColor,
        ),
        space,
      ],
    );
  }
}
