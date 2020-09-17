import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    //darker shade
    scaffoldBackgroundColor: Color(0xffffffff),
    //stats cards
    backgroundColor: Color.fromARGB(255, 214, 239, 218),
    cardColor: Color.fromARGB(255, 243, 209, 210),
    accentColor: Color.fromARGB(255, 221, 222, 248),
    //all text
    textTheme: TextTheme(
      bodyText1: TextStyle(color: Colors.black, fontFamily: 'verdana0'),
    ),
    //lighter shade
    disabledColor: Color(0xf3f3f3f3),
  );

  static final ThemeData darkTheme = ThemeData(
    //darker shade
    scaffoldBackgroundColor: Color(0xff15131E),
    //stats cards
    backgroundColor: Color(0xff51B328),
    cardColor: Color(0xFFFF4A2B),
    accentColor: Color(0xff3D84FA),
    //lighter shade
    disabledColor: Color(0xff211E2B),
    //all text
    textTheme: TextTheme(
      bodyText1: TextStyle(color: Colors.white, fontFamily: 'verdana0'),
    ),
  );
}
