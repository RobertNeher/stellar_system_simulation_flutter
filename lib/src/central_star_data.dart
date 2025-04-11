import 'package:flutter/material.dart';
import 'package:planet_simulation_flutter/src/parameter.dart';
import 'package:vector_math/vector_math.dart' as vector;

class CentralStarData {
  String name;
  double diameter;
  double mass;
  vector.Vector2 position;
  vector.Vector2 velocity;
  Color color;
  int size;
  late Parameter parameter;

  CentralStarData({
    required this.name,
    required this.diameter,
    required this.mass,
    required this.position,
    required this.velocity,
    required this.color,
    required this.size,
    required this.parameter,
  });

  factory CentralStarData.fromJson(Map<String, dynamic> json) {
    return CentralStarData(
      name: json['name'],
      diameter: json['diameter'].toDouble(),
      mass: json['mass'].toDouble(),
      position: vector.Vector2(
        json['centerX'].toDouble(),
        json['centerY'].toDouble(),
      ),
      velocity: vector.Vector2(
        json['velocityX'].toDouble(),
        json['velocityY'].toDouble(),
      ),
      color: Color(int.parse("0xff${json['color'].substring(1)}")),
      size: json['size'],
      parameter: Parameter.fromJson(json['parameter']),
    );
  }

  @override
  String toString() {
    print("Central Star");
    print("Name: ${this.name}");
    print("Diameter: ${this.diameter}");
    print("Mass: ${this.mass}");
    print("Position: ${this.position}");
    print("VelocityX/Y: ${this.velocity}");
    print("Color: ${this.color.toString()}");
    print("Size: ${this.size}");
    return super.toString();
  }
}
