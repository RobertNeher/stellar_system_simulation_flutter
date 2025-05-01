import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vector;

class Planet {
  String name;
  double distance;
  double period;
  double eccentricity;
  double radius;
  double mass;
  double velocity;
  Color color;
  vector.Vector2 position;
  int size;

  Planet({
    required this.name,
    required this.distance,
    required this.period,
    required this.eccentricity,
    required this.radius,
    required this.mass,
    required this.velocity,
    required this.color,
    required this.position,
    required this.size,
  });

  factory Planet.fromJson(Map<String, dynamic> json, double AU) {
    return Planet(
      name: json['name'],
      distance: json['distance'].toDouble(),
      period: json['period'].toDouble(),
      eccentricity: json['eccentricity'].toDouble(),
      radius: json['radius'].toDouble(),
      mass: json['mass'].toDouble(),
      velocity: json['velocity'].toDouble(),
      position: vector.Vector2(json['distance'].toDouble() * AU, 0),
      color: Color(int.parse('0xff${json['color'].substring(1)}')),
      size: json['size'],
    );
  }
  @override
  String toString() {
    print("Planet ${this.name}");
    print("Distance ${this.distance}"); // in AU
    print(
      "Period: ${this.period}",
    ); // time for complete orbit around the central star in Earth days
    print("Eccentricity: ${this.eccentricity}");
    print("Radius ${this.radius}"); // in m
    print("Mass ${this.mass}"); //
    print("Velocity ${this.velocity}"); // in m/s
    print("Position ${this.position}"); // in m
    print("Color ${this.color}");
    print("Size ${this.size}");

    return super.toString();
  }
}
