import 'package:flutter/material.dart';

// colorString is expected in following format:
// '#<red in hex><green in hex><blue in hex>', eg. '#262626'
Color colorFromString(String colorString) {
  String color = '0xff${colorString.substring(1)}';
  return Color(int.parse(color));
}

Color complimentaryColor(String rgb) {
  Color color = colorFromString(rgb);
  return Color.fromARGB(
    color.a.toInt(),
    255 - color.r.toInt(),
    255 - color.b.toInt(),
    255 - color.g.toInt(),
  );
}
