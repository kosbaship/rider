import 'package:flutter/material.dart';

import 'colors.dart';



ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: kForthColor,
    fontFamily: "Muli",
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    primarySwatch: kMaterialColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide(color: kGreyColor),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}

TextTheme textTheme() {
  return TextTheme(
    bodyText1: TextStyle(color: kGreyColor),
    bodyText2: TextStyle(color: kGreyColor),
  ).apply(
    bodyColor: kSecondaryColor,
    displayColor: kSecondaryColor,
    // fontFamily: 'Signatra',
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: kMainColor,
    elevation: 0,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: kForthColor),
    textTheme: TextTheme(
      headline6: TextStyle(color: kLightColor, fontSize: 18),
    ),
  );
}
