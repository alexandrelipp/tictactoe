import 'package:flutter/material.dart';

IconData firstIcon = Icons.close;
IconData secondIcon = Icons.radio_button_off;
Color firstIconColor = Colors.black;
Color secondIconColor = Colors.red;

ThemeData myTheme = ThemeData(
  textTheme: TextTheme(
    headline1: TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.w700,
    ),
  ),
  primaryColor: Colors.grey[600],
  backgroundColor: Colors.grey[400],
  primarySwatch: Colors.grey,
);
