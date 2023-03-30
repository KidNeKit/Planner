import 'package:flutter/material.dart';
import 'colors.dart';

ThemeData baseTheme = ThemeData(
  primaryColor: darkGreenColor,
  textTheme: textTheme,
  elevatedButtonTheme: buttonThemeData,
);

TextTheme textTheme = TextTheme(
  labelLarge: labelLarge,
  labelMedium: labelMedium,
  labelSmall: labelSmall,
  bodyLarge: bodyLarge,
  bodyMedium: bodyMedium,
  bodySmall: bodySmall,
);

ElevatedButtonThemeData buttonThemeData = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
    backgroundColor: darkGreenColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    foregroundColor: lightColor,
  ),
);

TextStyle bodyLarge = TextStyle(
  color: darkColor,
  fontSize: 40,
  fontWeight: FontWeight.bold,
);

TextStyle bodyMedium = TextStyle(
  color: darkColor,
  fontSize: 34,
  fontWeight: FontWeight.bold,
);

TextStyle bodySmall = TextStyle(
  color: darkColor,
  fontSize: 30,
  fontWeight: FontWeight.bold,
);

TextStyle labelLarge = TextStyle(
  color: darkColor,
  fontSize: 24,
  fontWeight: FontWeight.bold,
);

TextStyle labelMedium = TextStyle(
  color: darkColor,
  fontSize: 20,
);

TextStyle labelSmall = TextStyle(
  color: darkColor,
  fontSize: 16,
);
