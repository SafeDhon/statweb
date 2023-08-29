// import 'dart:js';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

var myDefaultBackground = Colors.grey[300];

int tabletWidth = 1350;
int mobileWidth = 1150;

var myAppBar = AppBar(
  centerTitle: true,
  title: const Text('Stat Tablet'),
  backgroundColor: metallicBlue,
);

var paleYellow = const Color(0xFFFBFBBC);
var milk = const Color(0xFFFDFFF5);
var water = const Color(0xFFD8EBFE);
var beauBlue = const Color(0xFFB8CDEF);
var glaucous = const Color(0xFF5B79B1);
var metallicBlue = const Color(0xFF2E4882);

// String engFont = 'QuickSand';
// var thFont = 'EkkamaiNew';

TextStyle enFont(String myfontWeight, double fontSize, Color color) {
  return TextStyle(
      color: color,
      fontSize: fontSize,
      fontFamily: 'Quicksand',
      fontWeight: myfontWeight == 'bold'
          ? FontWeight.w700
          : myfontWeight == 'semibold'
              ? FontWeight.w600
              : myfontWeight == 'medium'
                  ? FontWeight.w500
                  : myfontWeight == 'regular'
                      ? FontWeight.w400
                      : myfontWeight == 'light'
                          ? FontWeight.w300
                          : FontWeight.w700);
}

TextStyle thFont(String myfontWeight, double fontSize, Color color) {
  return TextStyle(
      color: color,
      fontSize: fontSize,
      fontFamily: 'EkkamaiNew',
      fontWeight: myfontWeight == 'bold'
          ? FontWeight.w700
          : myfontWeight == 'regular'
              ? FontWeight.w400
              : myfontWeight == 'thin'
                  ? FontWeight.w300
                  : FontWeight.w700);
}

Center myCircularLoading() {
  return Center(
    child: CircularProgressIndicator(
      strokeWidth: 3.0,
      color: glaucous,
    ),
  );
}

Widget menuItem(
    int id, String title, IconData icon, bool selected, Function() onTap) {
  return Material(
    color: selected ? Colors.white10 : Colors.transparent,
    child: InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Icon(
                icon,
                size: 20,
                color: Colors.white,
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

enum DrawerSections {
  home,
  eBook,
  quiz,
  score,
  research,
  logout,
}

FirebaseOptions myFirebaseOptions() {
  return const FirebaseOptions(
    apiKey: "AIzaSyAlt6_3aWnfL0t5bJvrYWPlk_hBwE_K2sA",
    appId: "1:473452586512:web:35fc61af78d83bc2fecc95",
    messagingSenderId: "473452586512",
    projectId: "reportstatweb",
    storageBucket: "reportstatweb.appspot.com",
  );
}

Theme dateTimePickTheme(BuildContext context,Widget? child) {
  return Theme(
              data: Theme.of(context).copyWith(
                textTheme: TextTheme(
                  headlineLarge: enFont('semibold', 15, metallicBlue),
                  headlineMedium: enFont('semibold', 15, metallicBlue),
                  headlineSmall: enFont('semibold', 15, metallicBlue),
                  displayLarge: enFont('semibold', 15, metallicBlue),
                  displayMedium: enFont('semibold', 15, metallicBlue),
                  displaySmall: enFont('semibold', 15, metallicBlue),
                  titleLarge: enFont('semibold', 15, metallicBlue),
                  titleMedium: enFont('semibold', 15, metallicBlue),
                  titleSmall: enFont('semibold', 15, metallicBlue),
                  bodyLarge: enFont('semibold', 15, metallicBlue),
                  bodyMedium: enFont('semibold', 15, metallicBlue),
                  bodySmall: enFont('semibold', 15, metallicBlue),
                  labelLarge: enFont('semibold', 15, metallicBlue),
                  labelMedium: enFont('semibold', 15, metallicBlue),
                  labelSmall: enFont('semibold', 15, metallicBlue),
                ),
                inputDecorationTheme: InputDecorationTheme(
                  labelStyle:
                      enFont('semibold', 15, metallicBlue), // Input label
                ),
                colorScheme: ColorScheme.light(
                  primary: metallicBlue, // <-- SEE HERE
                  onPrimary: Colors.white, // <-- SEE HERE
                  onSurface: metallicBlue, // <-- SEE HERE
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                      textStyle: enFont(
                          'semibold', 15, metallicBlue) // button text color
                      ),
                ),
              ),
              child: child!);
}