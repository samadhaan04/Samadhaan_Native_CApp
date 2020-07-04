
import 'package:faridabad/screens/authScreen.dart';
import 'package:faridabad/screens/base.dart';
import 'package:faridabad/screens/example.dart';
import 'package:faridabad/screens/filecomplaint.dart';
import 'package:faridabad/screens/home.dart';
import 'package:faridabad/screens/loader.dart';
import 'package:faridabad/screens/previouscomplaints.dart';
import 'package:faridabad/screens/showcomplaint.dart';
import 'package:faridabad/screens/splash_screen.dart';
import 'package:faridabad/screens/user_info.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Samadhaan',
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
      },
    );
  }
}
