import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme:
    AppBarTheme(
      centerTitle: true,
      color: Colors.white,
      elevation: 10,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: Colors.black45,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    fontFamily: "Muli",
    textTheme: TextTheme(
      bodyText1: TextStyle(color: Colors.black),
      bodyText2: TextStyle(color: Colors.black),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
