import 'dart:async';
import 'package:faridabad/adminScreens/adminUI.dart';
import 'package:faridabad/providers/auth.dart';
import 'package:faridabad/clientScreens/base.dart';
import 'package:faridabad/loginScreen.dart';
import 'package:faridabad/login.dart';
import 'package:faridabad/clientScreens/user_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var _auth = Auth();

  Future<void> getTheme() async {
    final pref = await SharedPreferences.getInstance();
    var theme = pref.getString('theme');
    print('theme $theme');
    if (theme == null) {
    } else if (theme == 'dark') {
      Provider.of<AppStateNotifier>(context, listen: false).updateTheme(true);
    } else {
      Provider.of<AppStateNotifier>(context, listen: false).updateTheme(false);
    }
  }

  void movetoHome() async {
    final pref = await SharedPreferences.getInstance();
    final result = await _auth.autoLogin();
    await Future.delayed(Duration(milliseconds: 2000));
    print('result $result');
    if (result == true) {
      var currentUser = pref.getString('currentUser');
      if (currentUser == 'client') {
        final check = await _auth.checkuserInfo();
        if (check) {
          Navigator.of(context).pushReplacementNamed(Base.routeName);
        } else {
          Navigator.of(context).pushReplacementNamed(UserInfoScreen.routeName);
        }
      } else {
        Navigator.of(context)
            .pushReplacementNamed(AdminUi.routeName, arguments: currentUser);
      }
    } else {
      Navigator.of(context).pushReplacementNamed(Login.routeName);
    }
  }

  @override
  void initState() {
    movetoHome();
    getTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              color: Color(0xff404543),
              fontSize: 60.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
