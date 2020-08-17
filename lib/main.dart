import 'package:faridabad/main2.dart';
import 'package:faridabad/main3.dart';
import 'package:faridabad/screens/adminScreen.dart';
import 'package:faridabad/screens/authScreen.dart';
import 'package:faridabad/screens/base.dart';
import 'package:faridabad/screens/complaint_details.dart';
import 'package:faridabad/screens/example.dart';
import 'package:faridabad/screens/filecomplaint.dart';
import 'package:faridabad/screens/home.dart';
import 'package:faridabad/screens/input_data.dart';
import 'package:faridabad/screens/previouscomplaints.dart';
import 'package:faridabad/screens/prevtest.dart';
import 'package:faridabad/screens/showcomplaint.dart';
import 'package:faridabad/screens/splash_screen.dart';
import 'package:faridabad/screens/user_info.dart';
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
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
      routes: {
        AuthScreen.routeName: (ctx) => AuthScreen(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
        UserInfoScreen.routeName: (ctx) => UserInfoScreen(),
        ExampleScreen.routeName: (ctx) => ExampleScreen(),
        ShowComplaint.routeName: (ctx) => ShowComplaint(),
        FileComplaint.routeName: (ctx) => FileComplaint(),
        Base.routeName: (ctx) => Base(),
        PreviousComplanints.routeName : (ctx) => PreviousComplanints(),
        PreviousComplanintst.routeName : (ctx) => PreviousComplanintst(),
        AdminScreen.routename : (ctx) => AdminScreen(),
        AdminApp.routeName : (ctx) => AdminApp(),
        ComplaintDetails.routeName : (ctx) => ComplaintDetails(),
        AdminUi.routeName : (ctx) => AdminUi(),
      },
    );
  }
}
