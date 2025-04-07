import 'package:flutter/material.dart';

class Parameter {
  int windowSize = 0;
  double centerX = 0;
  double centerY = 0;
  String font = "";
  int fontSize = 0;
  double astronomicalUnit = 0;
  double gravityConstant = 0;
  double scaleFactor = 0;
  int updatePeriod = 0;
  int timeStep = 0;
  Color backgroundColor = Colors.black;
  bool stars = true;
  Color starColor = const Color(0xFFFFD740);
  int starCount = 0;

  Parameter({
    required this.windowSize,
    required this.centerX,
    required this.centerY,
    required this.font,
    required this.fontSize,
    required this.astronomicalUnit,
    required this.gravityConstant,
    required this.scaleFactor,
    required this.updatePeriod,
    required this.timeStep,
    required this.backgroundColor,
    required this.stars,
    required this.starColor,
    required this.starCount
  });

  factory Parameter.fromJson(Map<String, dynamic> json) {
    return Parameter(
      windowSize: json['windowSize'],
      centerX: json['centerX'].toDouble(),
      centerY: json['centerY'].toDouble(),
      font: json['font'],
      fontSize: json['fontSize'],
      astronomicalUnit: json['astronomicalUnit'].toDouble(),
      gravityConstant: json['gravityConstant'].toDouble(),
      scaleFactor: json['scaleFactor'].toDouble(),
      updatePeriod: json['updatePeriod'],
      timeStep: json['timeStep'],
      backgroundColor: Color(
        int.parse("0xff${json['backgroundColor'].substring(1)}"),
      ),
      stars: json['stars'],
      starColor: Color(int.parse("0xff${json['starColor'].substring(1)}")),
      starCount: json['starCount']
    );
  }

  @override
  String toString() {
    print("Parameters");
    print("AU: ${this.astronomicalUnit}");
    print("Window Size: ${this.windowSize}");
    print("Gravity Constant: ${this.gravityConstant}");
    print("centerX/Y: ${this.centerX}/${this.centerY}");
    print("Font: ${this.font}(${this.fontSize})");
    print("Scale: ${this.scaleFactor}");
    print("Timestep: ${this.timeStep}");
    print("Period: ${this.updatePeriod}");
    print("bg color: ${this.backgroundColor}");
    print("Stars: ${this.stars}");
    print("Star color: ${this.starColor}");
    print("Star count: ${this.starCount}");
    return super.toString();
  }
}
