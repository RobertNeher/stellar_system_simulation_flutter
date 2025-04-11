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
      Star star = Star(
        starColor: widget.parameter.starColor,
        windowSize: widget.parameter.windowSize.toDouble(),
        starSize: widget.parameter.starSize,
      );
      stars.add(
        Positioned(
          top: 0,
          left: 0,
          width: widget.parameter.starSize,
          height: widget.parameter.starSize,
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
