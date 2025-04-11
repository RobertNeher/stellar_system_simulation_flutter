import 'package:flutter/material.dart';

class Parameter {
  int windowSize = 0;
  String font = "";
  int fontSize = 0;
  double astronomicalUnit = 0;
  double gravityConstant = 0;
  double scaleFactor = 0;
  int updatePeriod = 0;
  int timeStep = 0;
  Color backgroundColor = Colors.black;
  bool backgroundStars = false;
  int maxStars = 0;
  double starSize = 0;
  Color starColor = Colors.amberAccent;

  Parameter({
    required this.windowSize,
    required this.font,
    required this.fontSize,
    required this.astronomicalUnit,
    required this.gravityConstant,
    required this.scaleFactor,
    required this.updatePeriod,
    required this.timeStep,
    required this.backgroundColor,
    required this.backgroundStars,
    required this.maxStars,
    required this.starSize,
    required this.starColor,
  });

  factory Parameter.fromJson(Map<String, dynamic> json) {
    return Parameter(
      windowSize: json['windowSize'],
      font: json['font'],
      fontSize: json['fontSize'],
      astronomicalUnit: json['astronomicalUnit'].toDouble(),
      gravityConstant: json['gravityConstant'].toDouble(),
      scaleFactor: double.parse(json['scaleFactor']),
      updatePeriod: json['updatePeriod'],
      timeStep: json['timeStep'],
      backgroundColor: Color(
        int.parse("0xff${json['backgroundColor'].substring(1)}"),
      ),
      backgroundStars: json['backgroundStars'],
      maxStars: json['maxStars'],
      starSize: json['starSize'].toDouble(),
      starColor: Color(int.parse("0xff${json['starColor'].substring(1)}")),
    );
  }

  @override
  String toString() {
    print("Parameters");
    print("AU: ${this.astronomicalUnit}");
    print("Window size: ${this.windowSize}");
    print("Gravity Constant: ${this.gravityConstant}");
    print("Font: ${this.font}(${this.fontSize})");
    print("Scale: ${this.scaleFactor}");
    print("Timestep: ${this.timeStep}");
    print("Period: ${this.updatePeriod}");
    print("bg color: ${this.backgroundColor}");
    print("bg stars: ${this.backgroundStars}");
    print("Maximum stars: ${this.maxStars}");
    print("Star size: ${this.starSize}");
    print("Star color: ${this.starColor}");

    return super.toString();
  }
}
