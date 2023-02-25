import 'package:flutter/material.dart';

class Themes {
  static ThemeData lightMode(BuildContext context) => ThemeData(
    primarySwatch: Colors.indigo,
    fontFamily: "Rubik",
    canvasColor: lightBg,
    appBarTheme: const AppBarTheme(
      color: lightAccent,
      iconTheme: IconThemeData(color: Color(0xff0e0d18)),
      titleTextStyle: TextStyle(
        color: Color(0xff0e0d18),
        fontFamily: "Rubik",
        fontWeight: FontWeight.bold,
        fontSize: 21.0
      )
    )
  );

  static ThemeData darkMode(BuildContext context) => ThemeData(
      primarySwatch: Colors.deepPurple,
      fontFamily: "Rubik",
      textTheme: Theme.of(context).textTheme.apply(
        bodyColor: lightBg,
        // displayColor: lightBg
      ),
      canvasColor: darkBg,
      appBarTheme: const AppBarTheme(
        color: darkAccent,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          fontFamily: "Rubik",
          fontWeight: FontWeight.bold,
          fontSize: 21.0
        )
      )
  );

  // colors
  static const Color lightBg = Color(0xffd2def4);
  static const Color lightAccent = Color(0xff2ccea5);
  static const Color darkBg = Color(0xff0e0d18);
  static const Color darkAccent = Color(0xff7563f6);
}
