import 'package:flutter/material.dart';
import 'package:flutter_travelapp/constants.dart';

ThemeData theme(BuildContext context) {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Muli",
    appBarTheme: appBarTheme(context),
    textTheme: textTheme(), 
    inputDecorationTheme: inputDecorationTheme() ,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primarySwatch: Colors.blue,
  );
}

InputDecorationTheme inputDecorationTheme() {
  var outlineInputBorder = OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: kTextColor),
          gapPadding: 10);
  return InputDecorationTheme(
    
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 42, vertical: 20),
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      border: outlineInputBorder
    );
}
TextTheme textTheme(){
  return const TextTheme(
        bodyText1: TextStyle(color: kTextColor),
        bodyText2: TextStyle(color: kTextColor));
}
AppBarTheme appBarTheme(BuildContext context) {
  return AppBarTheme(
    color: Colors.white,
    elevation: 0,
    iconTheme: const IconThemeData(color: Colors.black),
    titleTextStyle: Theme.of(context)
        .textTheme
        .headline6
        ?.copyWith(color: const Color(0XFF8B8B8B), fontSize: 18),
  );
}
