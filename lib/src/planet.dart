import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vector;

class Planet {
  String name;
  double diameter;
  double mass;
  vector.Vector2 position;
  vector.Vector2 velocity;
  Color color;
  int size;

  Planet({
    required this.name,
    required this.diameter,
    required this.mass,
    required this.position,
    required this.velocity,
    required this.color,
    required this.size,
  });

  factory Planet.fromJson(Map<String, dynamic> json) {
    return Planet(
      name: json['name'],
      diameter: json['diameter'].toDouble(),
      mass: json['mass'].toDouble(),
      position: vector.Vector2(json['distance'].toDouble(), 0),
      velocity: vector.Vector2(
        json['velocityX'].toDouble(),
        json['velocityY'].toDouble(),
      ),
      color: Color(int.parse('0xff${json['color'].substring(1)}')),
      size: json['size'],
    );
  }
}
