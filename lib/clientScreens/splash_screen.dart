import 'dart:async';
import 'package:faridabad/adminScreens/ComplaintScreen.dart';
import 'package:faridabad/adminScreens/adminUI.dart';
import 'package:faridabad/providers/auth.dart';
import 'package:faridabad/clientScreens/base.dart';
import 'package:faridabad/loginScreen.dart';
import 'package:faridabad/adminScreens/departments.dart';
import 'package:faridabad/clientScreens/user_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var _auth = Auth();

  void movetoHome() async {
    final pref = await SharedPreferences.getInstance();
    await Future.delayed(Duration(milliseconds: 2000));
    final result = await _auth.autoLogin();
    print('result $result');
    if (result == true) {
      var currentUser = pref.getString('currentUser');
      print('currentUser $currentUser');
      if (currentUser == 'client') 
      {
        final check = await _auth.checkuserInfo();
        if (check)
        {
          Navigator.of(context).pushReplacementNamed(Base.routeName);
        } 
        else 
        {
          Navigator.of(context).pushReplacementNamed(UserInfoScreen.routeName);
        }
      } 
      else 
      {
        Navigator.of(context).pushReplacementNamed(AdminUi.routeName,arguments: currentUser);
      }
    } 
    else 
    {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }
  }

  @override
  void initState() {
    movetoHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Hero(
              tag: 'logo',
              child: Image.asset(
                'assets/images/samadhaan.png',
                width: MediaQuery.of(context).size.width * .5,
              ),
            ),
          ),
          Text(
            'Samadhaan',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Lobster',
              color: Colors.white,
              fontSize: 60.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
