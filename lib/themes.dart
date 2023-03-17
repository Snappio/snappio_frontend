import 'package:flutter/material.dart';

class Themes {
  static ThemeData lightMode(BuildContext context) => ThemeData(
    primarySwatch: Colors.indigo,
    fontFamily: "Rubik",
    textTheme: Theme.of(context).textTheme.apply(
      bodyColor: darkBg,
      displayColor: darkBg,
      fontFamily: "Rubik"
    ),
    canvasColor: lightBg,
    cardColor: lightAccent,
    primaryColor: Colors.indigoAccent,
    splashColor: darkBg,
    appBarTheme: const AppBarTheme(
      color: lightAccent,
      iconTheme: IconThemeData(color: darkBg),
      titleTextStyle: TextStyle(
        color: darkBg,
        fontFamily: "Rubik",
        fontWeight: FontWeight.bold,
        fontSize: 21.0
      )
    )
  );

  static ThemeData darkMode(BuildContext context) => ThemeData(
      primarySwatch: Colors.deepPurple,
      brightness: Brightness.dark,
      fontFamily: "Rubik",
      textTheme: Theme.of(context).textTheme.apply(
        bodyColor: lightBg,
        displayColor: lightBg,
        fontFamily: "Rubik"
      ),
      canvasColor: darkBg,
      cardColor: darkAccent,
      primaryColor: Colors.white60,
      splashColor: lightBg,
      appBarTheme: const AppBarTheme(
        color: darkAccent,
        iconTheme: IconThemeData(color: lightBg),
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
