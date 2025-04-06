import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vector;

class CentralStar {
  String name;
  double diameter;
  double mass;
  vector.Vector2 position;
  vector.Vector2 velocity;
  Color color;
  int size;

  CentralStar({
    required this.name,
    required this.diameter,
    required this.mass,
    required this.position,
    required this.velocity,
    required this.color,
    required this.size,
  });

  factory CentralStar.fromJson(Map<String, dynamic> json) {
    return CentralStar(
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
      // color: int.parse("0x${json['color'].substring(1)}"),
      color: Color(int.parse("0x${json['color'].substring(1)}")),
      size: json['size'],
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
