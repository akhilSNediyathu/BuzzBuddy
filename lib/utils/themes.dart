import 'package:buzz_buddy/utils/constants.dart';
import 'package:flutter/material.dart';

class Themes {
  static ThemeData lightModeTheme = ThemeData.light().copyWith(
    appBarTheme: const AppBarTheme(
        color: kPrimaryColor, surfaceTintColor: kPrimaryColor),
    scaffoldBackgroundColor: kwhiteColor,
    elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(grey))),
  );

  static ThemeData darkModeTheme = ThemeData.dark().copyWith(
      appBarTheme: const AppBarTheme(color: black, surfaceTintColor: black),
      scaffoldBackgroundColor: const Color.fromARGB(255, 23, 22, 22),
      elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(kPrimaryColor))));
}
