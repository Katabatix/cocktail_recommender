import 'package:flutter/material.dart';

//Color.fromARGB(1, 42, 42, 55) background grey
//
ThemeData getThemeData() {
  return ThemeData(
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.grey,
      elevation: 10,
      selectedLabelStyle: TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontFamily: 'Montserrat',
          fontSize: 14.0),
      unselectedLabelStyle: TextStyle(
          color: Colors.black, fontFamily: 'Montserrat', fontSize: 12.0),
      selectedItemColor: Color.fromARGB(255, 255, 255, 255),
      unselectedItemColor: Colors.black,
      showUnselectedLabels: true,
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromARGB(255, 245, 126, 182),
      onPrimary: Colors.grey.shade900,
      secondary: Colors.indigo.shade900,
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.black,
      background: Color.fromARGB(255, 42, 42, 55),
      onBackground: Colors.grey.shade900,
      surface: Colors.blueGrey.shade100,
      onSurface: Colors.grey.shade900,
    ),
  );
}
