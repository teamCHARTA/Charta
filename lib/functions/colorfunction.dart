import 'dart:math';
import 'package:flutter/material.dart';

class someColor{

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.9),
    100: tintColor(color, 0.8),
    200: tintColor(color, 0.6),
    300: tintColor(color, 0.4),
    400: tintColor(color, 0.2),
    500: color,
    600: shadeColor(color, 0.1),
    700: shadeColor(color, 0.2),
    800: shadeColor(color, 0.3),
    900: shadeColor(color, 0.4),
  });
}

int tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color tintColor(Color color, double factor) =>
    Color.fromRGBO(
        tintValue(color.red, factor),
        tintValue(color.green, factor),
        tintValue(color.blue, factor),
        1);

int shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color shadeColor(Color color, double factor) =>
    Color.fromRGBO(
        shadeValue(color.red, factor),
        shadeValue(color.green, factor),
        shadeValue(color.blue, factor),
        1);}
class Palette {
  static const Color container = Color(0xff7fc2ae);
  static const Color primary = Color(0xff12b190);
  static const Color background = Color(0xfa66a7a1);
  static const Color secondary = Color(0xfff0fffb);
  static const Color divider = Color(0xffffffff);
}