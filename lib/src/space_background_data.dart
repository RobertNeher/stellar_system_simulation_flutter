import 'package:flutter/material.dart';

class SpaceBackgroundData {
  Color backgroundColor = Colors.black;
  bool stars = true;
  int starEdges = 0;
  Color starColor = Colors.black;
  int maxStars = 0;
  Size starSize = Size.zero;

  SpaceBackgroundData({
    required this.backgroundColor,
    required this.stars,
    required this.starSize,
    required this.starEdges,
    required this.starColor,
    required this.maxStars,
  });

  factory SpaceBackgroundData.fromJson(Map<String, dynamic> json) {
    return SpaceBackgroundData(
      backgroundColor: Color(
        int.parse("0xff${json['backgroundColor'].substring(1)}"),
      ),
      stars: json['stars'],
      starSize: Size(json['starSize'], json['starSize']),
      starEdges: json['starEdges'],
      starColor: Color(int.parse("0xff${json['starColor'].substring(1)}")),
      maxStars: json['maxStars'],
    );
  }

  @override
  String toString() {
    print("Space Background Data");
    print("bg color: ${this.backgroundColor}");
    print("Stars? ${this.stars}");
    print("Star edges: ${this.starEdges}");
    print("Star Color: ${this.starColor}");
    print("Max. Stars: ${this.maxStars}");

    return super.toString();
  }
}
