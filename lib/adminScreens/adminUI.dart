import 'package:faridabad/adminScreens/adminProfile.dart';
import 'package:faridabad/main.dart';
import 'package:faridabad/adminScreens/ComplaintScreen.dart';
import 'package:faridabad/adminScreens/complaint_details.dart';
import 'package:faridabad/loginScreen.dart';
import 'package:faridabad/adminScreens/departments.dart';
import 'package:flutter/material.dart';

class AdminUi extends StatelessWidget {
  static const routeName = '/adminUi';

  @override
  Widget build(BuildContext context) {
    var user = ModalRoute.of(context).settings.arguments;
    print('adminUI $user');
    return MaterialApp(
      title: 'Samadhaan UI',
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context),
      routes: {
        ComplaintScreen.routeName: (ctx) => ComplaintScreen(),
        ComplaintDetails.routeName: (ctx) => ComplaintDetails(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
        MyApp.routeName: (ctx) => MyApp(),
        AdminProfile.routename: (ctx) => AdminProfile(),
        InputData.routeName: (ctx) => InputData(),
      },
      home: user == 'admin' ? InputData() : ComplaintScreen(user),
    );
  }
}
