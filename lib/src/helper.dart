import 'dart:math';
import 'package:flutter/material.dart';

// colorString is expected in following format:
// '#<red in hex><green in hex><blue in hex>', eg. '#262626'
Color colorFromString(String colorString) {
  String color = '0xff${colorString.substring(1)}';
  return Color(int.parse(color));
}

Color complimentaryColor(Color color) {
  return Color.fromARGB(
    255 - color.a.toInt(),
    255 - color.r.toInt(),
    255 - color.b.toInt(),
    255 - color.g.toInt(),
  );
}

Color randomColor() {
  return Color.from(
    alpha: 255,
    red: Random().nextDouble() * 256,
    green: Random().nextDouble() * 256,
    blue: Random().nextDouble() * 256,
  );
}
