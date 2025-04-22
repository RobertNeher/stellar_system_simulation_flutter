import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vector;

class Planet {
  String name;
  double diameter;
  double period;
  double mass;
  vector.Vector2 position;
  vector.Vector2 velocity;
  Color color;
  int size;

  Planet({
    required this.name,
    required this.diameter,
    required this.period,
    required this.mass,
    required this.position,
    required this.velocity,
    required this.color,
    required this.size,
  });

  factory Planet.fromJson(Map<String, dynamic> json, double AU) {
    return Planet(
      name: json['name'],
      diameter: json['diameter'].toDouble(),
      period: json['period'].toDouble(),
      mass: json['mass'].toDouble(),
      position: vector.Vector2(json['distance'].toDouble() * AU, 0),
      velocity: vector.Vector2(
        json['velocityX'].toDouble(),
        json['velocityY'].toDouble(),
      ),
      color: Color(int.parse('0xff${json['color'].substring(1)}')),
      size: json['size'],
    );
  }
  @override
  String toString() {
    print("Planet ${this.name}");
    print("Position ${this.position}");
    print("Velocity ${this.velocity}");
    print("Color ${this.color}");
    print("Size ${this.size}");
    print("Diameter ${this.diameter}");
    print("Mass ${this.mass}");
    print("Period: ${this.period}");

    return super.toString();
  }
}
