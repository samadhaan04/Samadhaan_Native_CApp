import 'package:faridabad/main.dart';
import 'package:faridabad/adminScreens/ComplaintScreen.dart';
import 'package:faridabad/adminScreens/complaint_details.dart';
import 'package:faridabad/clientScreens/loginScreen.dart';
import 'package:faridabad/adminScreens/departments.dart';
import 'package:flutter/material.dart';

void main() => runApp(AdminUi());

class AdminUi extends StatelessWidget {
  static const routeName = '/adminUi';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Samadhaan UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      routes: {
        ComplaintScreen.routeName : (ctx) => ComplaintScreen(),
        ComplaintDetails.routeName : (ctx) => ComplaintDetails(),
        HomeScreen.routeName : (ctx) => HomeScreen(),
        MyApp.routeName : (ctx) => MyApp(),
      },
      home: InputData(),
    );
  }
}
