import 'package:flutter/material.dart';
import 'colors.dart';

ThemeData baseTheme = ThemeData(
  primaryColor: primaryColor,
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
  titleMedium: titleMedium,
  titleSmall: titleSmall,
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
  color: neonGreen,
  fontSize: 48,
  fontFamily: 'Kanit',
  fontWeight: FontWeight.w700,
);

TextStyle bodyMedium = TextStyle(
  color: darkColor,
  fontSize: 34,
  fontWeight: FontWeight.bold,
);

TextStyle bodySmall = const TextStyle(
  color: Colors.white,
  fontSize: 30,
  fontWeight: FontWeight.bold,
);

// TextStyle titleLarge = const TextStyle(
//   color: Colors.white,
//   fontSize: 16,
//   fontFamily: 'Kanit',
//   fontWeight: FontWeight.w400,
// );

TextStyle titleMedium = const TextStyle(
  color: Colors.white,
  fontSize: 22,
  fontFamily: 'Kanit',
  fontWeight: FontWeight.w500,
);

TextStyle titleSmall = const TextStyle(
  color: Colors.white,
  fontSize: 20,
  fontFamily: 'Kanit',
  fontWeight: FontWeight.w500,
);

TextStyle labelLarge = const TextStyle(
  color: Colors.white,
  fontSize: 16,
  fontFamily: 'Kanit',
  fontWeight: FontWeight.w400,
);

TextStyle labelMedium = const TextStyle(
  color: Colors.white,
  fontSize: 14,
  fontFamily: 'Kanit',
  fontWeight: FontWeight.w400,
);

TextStyle labelSmall = const TextStyle(
  color: Colors.white,
  fontSize: 12,
  fontFamily: 'Kanit',
  fontWeight: FontWeight.w400,
);
