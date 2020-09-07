import 'package:faridabad/adminScreens/ComplaintScreen.dart';
import 'package:faridabad/main3.dart';
import 'package:faridabad/clientScreens/authScreen.dart';
import 'package:faridabad/clientScreens/base.dart';
import 'package:faridabad/adminScreens/complaint_details.dart';
import 'package:faridabad/clientScreens/filecomplaint.dart';
import 'package:faridabad/clientScreens/loginScreen.dart';
import 'package:faridabad/adminScreens/departments.dart';
import 'package:faridabad/clientScreens/previouscomplaints.dart';
import 'package:faridabad/clientScreens/showcomplaintNew.dart';
import 'package:faridabad/clientScreens/splash_screen.dart';
import 'package:faridabad/clientScreens/user_info.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const routeName  = '/myapp';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Samadhaan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // primaryColor: Color(0xFF0A0E21),
        // scaffoldBackgroundColor: Color(0xFF0A0E21),
        // textTheme: TextTheme(
        //   bodyText1: TextStyle(
        //     color: Colors.white,
        //   ),
        // ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
      routes: {
        AuthScreen.routeName: (ctx) => AuthScreen(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
        UserInfoScreen.routeName: (ctx) => UserInfoScreen(),
        FileComplaint.routeName: (ctx) => FileComplaint(),
        Base.routeName: (ctx) => Base(),
        PreviousComplaints.routeName : (ctx) => PreviousComplaints(),
        ComplaintScreen.routeName : (ctx) => ComplaintScreen(),
        ComplaintDetails.routeName : (ctx) => ComplaintDetails(),
        AdminUi.routeName : (ctx) => AdminUi(),
        ShowComplaintsNew.routeName : (ctx) => ShowComplaintsNew(),
        MyApp.routeName : (ctx) => MyApp(),
        InputData.routeName : (ctx) => InputData(),
      },
    );
  }
}
