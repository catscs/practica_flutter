import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  textTheme: TextTheme(
    bodyText2: TextStyle(
      color: Colors.white,
    ),
  ),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
        color: Colors.white
    ),
    brightness: Brightness.dark,
    backgroundColor: Colors.black,
    centerTitle: true,
    elevation: 0,
    textTheme: TextTheme(
      headline6: TextStyle(fontSize: 26.0, color: Colors.white),
    ),
  ),
);
