import 'dart:ui';

import 'package:flutter/Material.dart';

class ColorManager
{
  static const Color primary = Color(0xFFED9728);
  static const Color darkPrimary = Color(0xFFd17d11);
  static const Color lightPrimary = Color(0xCCFFC107);
  static const Color darkGrey = Color(0xCCA2A2A2);
  static Color darkDarkGrey = Colors.grey[200]!;
  static const Color lightGrey = Color(0xFF9E9E9E);
  static const Color grey = Color(0xFF707070);
  static const Color error = Color(0xFFe61f34);
  static const Color success = Color(0xFF4caf50);
  static const Color warning = Color(0xFFff9800);
  static const Color white = Colors.white;
  static const Color black = Color(0xFF000000);
  static const Color green = Colors.green;
  static const Color newPrimary = Colors.indigo;
  static  Color lightPurple = Colors.deepPurple[50]!;
  static  Color deepPurple = Colors.deepPurple;
  static const Color deepPurpleAccent = Colors.deepPurpleAccent;
  static const Color blueAccent = Colors.blueAccent;
  static const Color pinkAccent = Colors.pinkAccent;
  static const Color purpleAccent = Colors.purpleAccent;
  static const Color redAccent = Colors.redAccent;
  static const Color transparent = Colors.transparent;
  static Color deepPurpleWithOpacity = ColorManager.newPrimary.withOpacity(0.1);
  static Color indigo = Colors.indigo.shade900;

}