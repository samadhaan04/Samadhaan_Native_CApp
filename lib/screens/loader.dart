import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridabad/providers/auth.dart';
import 'package:faridabad/screens/example.dart';
import 'package:faridabad/screens/home.dart';
import 'package:faridabad/screens/user_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatefulWidget {
  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  void movetoHome() async {
    await Future.delayed(Duration(milliseconds: 2000));
    final result = await Auth().autoLogin();
    print(result);
    if (result) {
      final check = await Auth().checkuserInfo();
      print(check);
      if (check) {
        Navigator.of(context).pushReplacementNamed(ExampleScreen.routeName);
      } else {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      }
    }
    else
    {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }

    // // final result = await Auth().autoLogin();
    // // if(result == true)
    // // {
    // //   Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    // // }
    // // else
    // // {
    // //   final signInResult = await Auth().signInWithGoogle();
    // //   if(signInResult)
    // //   {
    // //     Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    // //   }
    // //   else
    // //   {
    // //     print('error');
    // //   }
    // }
  }

  @override
  void initState() {
    movetoHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Hero(
              tag: 'logo',
              child: Image(
                image: AssetImage('assets/images/logo.png'),
              ),
            ),
          ),
          Center(
            child: SpinKitChasingDots(
              color: Colors.white,
              size: 70,
            ),
          ),
        ],
      ),
    );
  }
}
