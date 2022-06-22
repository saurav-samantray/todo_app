import 'package:flutter/material.dart';

Map<int, Color> color =
{
  50:const Color.fromRGBO(255, 215, 0, .1),
  100:const Color.fromRGBO(255, 215, 0, .2),
  200:const Color.fromRGBO(255, 215, 0, .3),
  300:const Color.fromRGBO(255, 215, 0, .4),
  400:const Color.fromRGBO(255, 215, 0, .5),
  500:const Color.fromRGBO(255, 215, 0, .6),
  600:const Color.fromRGBO(255, 215, 0, .7),
  700:const Color.fromRGBO(255, 215, 0, .8),
  800:const Color.fromRGBO(255, 215, 0, .9),
  900:const Color.fromRGBO(255, 215, 0, 1),
};

class JTThemes {
  static const primary = Color(0xFFFFD700);
  static const primaryColor = Color(0xFFFFD700);
  static const primaryColorLight = Color(0xFFFAFAD2);
  static final darkPrimaryColor = Colors.grey.shade800;
  //static const darkPrimaryColor = Colors.black;
  static const widgetLightBackground = Colors.white70;
  static const widgetDarkBackground = Colors.grey;

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryTextTheme: TextTheme(labelSmall: TextStyle(color: Colors.grey.shade500)),
    primaryColorDark: darkPrimaryColor,
    primaryColor: darkPrimaryColor,
    primaryColorLight: primaryColorLight,
    backgroundColor: darkPrimaryColor,
    colorScheme: const ColorScheme.dark(primary: primary),
    dividerColor: Colors.white,
    cardColor: Colors.grey.shade600,
    iconTheme: IconThemeData(color: Colors.grey.shade100),
    secondaryHeaderColor: Colors.grey.shade100,
    highlightColor: Colors.white,
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.white,
    primaryColor: primaryColor,
    primaryColorDark: Colors.grey.shade800,
    primaryColorLight: primaryColorLight,
    colorScheme: const ColorScheme.light(primary: primary),
    dividerColor: Colors.black,
    cardColor: Colors.grey.shade100,
    iconTheme: IconThemeData(color: Colors.grey.shade800),
    secondaryHeaderColor: Colors.grey.shade700,
    highlightColor: primaryColor,
  );
}