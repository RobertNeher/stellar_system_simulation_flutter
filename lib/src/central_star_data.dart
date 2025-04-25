import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vector;

class CentralStarData {
  String name;
  double diameter;
  double mass;
  vector.Vector2 position;
  vector.Vector2 velocity;
  Color color;
  int sizeFactor;

  CentralStarData({
    required this.name,
    required this.diameter,
    required this.mass,
    required this.position,
    required this.velocity,
    required this.color,
    required this.sizeFactor,
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
      sizeFactor: json['sizeFactor'],
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
    print("Size factor: ${this.sizeFactor}");
    return super.toString();
  }
}
