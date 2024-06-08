import 'package:flutter/material.dart';

class AppColors {
  static Color green = Color(0xffB81736);
  // static Color green = Color(0xff281537);
  // static Color green = Color.fromRGBO(21, 97, 111, 1.0);
  static const Color white = Colors.white;
  static Color yellow = const Color.fromARGB(255, 229, 206, 0);
  static Color red = Colors.red;
  static Color bluegrey = Color(0xffB81736);
  static const gradient = LinearGradient(colors: [
    Color(0xffB81736),
    Color(0xff281537),
  ]);
  static const acceptGradient = LinearGradient(
  colors: [
    Color(0xFF4CAF50), // Green color for acceptance
    Color(0xFF388E3C), // A slightly darker shade of green
  ],
);

}
