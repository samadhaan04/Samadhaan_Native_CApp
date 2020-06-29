import 'file:///C:/Users/Siddharth%20Agarwal/Documents/github/Samadhaan_Native_CApp/lib/screens/filecomplaint.dart';
import 'package:faridabad/providers/auth.dart';
import 'package:faridabad/screens/home.dart';
import 'package:faridabad/screens/showcomplaint.dart';
import 'package:flutter/material.dart';

class ExampleScreen extends StatelessWidget {
  static const routeName = '/example';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton.icon(
            onPressed: () async {
              try {
                final result = await Auth().signOut();
                if (result) {
                  Navigator.of(context)
                      .pushReplacementNamed(HomeScreen.routeName);
                }
              } catch (e) {
                print(e);
              }
            },
            icon: Icon(Icons.minimize),
            label: Text('Sign out'),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushNamed(FileComplaint.routeName);
            },
            child: Text('Go To File Complaint'),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushNamed(ShowComplaint.routeName);
            },
            child: Text('Go To show Complaint'),
          ),
        ],
      ),
    ));
  }
}
