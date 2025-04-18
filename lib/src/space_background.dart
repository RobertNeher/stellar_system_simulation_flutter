import 'dart:math';
import 'package:flutter/material.dart';
import 'package:planet_simulation_flutter/src/parameter.dart';

import 'package:planet_simulation_flutter/src/space_background_data.dart';
import 'package:planet_simulation_flutter/src/star_painter.dart';

List<Widget> spaceBackground(
  Parameter parameter,
  SpaceBackgroundData backgroundData,
) {
  List<Widget> starsInSpace = <Widget>[];

  starsInSpace.add(
    Container(
      width: parameter.windowSize.toDouble(),
      height: parameter.windowSize.toDouble(),
      color: backgroundData.backgroundColor,
    ),
  );

  if (!backgroundData.stars) {
    return starsInSpace;
  }

  CustomPaint star = CustomPaint(
    painter: StarPainter(
      starSize: backgroundData.starSize,
      starColor: backgroundData.starColor,
      edges: backgroundData.starEdges,
    ),
  );

  for (int i = 0; i < backgroundData.maxStars; i++) {
    Positioned positionedStar = Positioned(
      left: Random().nextDouble() * parameter.windowSize,
      top: Random().nextDouble() * parameter.windowSize,
      child: star,
    );
    starsInSpace.add(positionedStar);
  }
  return starsInSpace;
}
