import 'package:flutter/material.dart';

class ColorProvider {
  final List<Color> colors = [
    Colors.purple[500],
    Colors.blue[500],
    Colors.orange[500],
    Colors.red[500],
    Colors.yellow[500],
    Colors.green[500],
    Colors.lightBlue[500],
    Colors.lightGreen[500],
    Colors.brown[500],
    Colors.indigo[500],
  ];

  Iterator color;

  ColorProvider() {
    this.color = colors.iterator;
  }

  Color getColor() {
    if (color.moveNext() == false) {
      color = colors.iterator;
      color.moveNext();
    }
    return color.current;
  }
}