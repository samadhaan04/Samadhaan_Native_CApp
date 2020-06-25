import 'package:faridabad/providers/auth.dart';
import 'package:faridabad/screens/home.dart';
import 'package:flutter/material.dart';

class ExampleScreen extends StatelessWidget {
  static const routeName = '/example';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: FlatButton.icon(
              onPressed: () async {
                try {
                  final result = await Auth().signOut();
                  if(result)
                  {
                    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                  }
                } catch (e) {
                  print(e);
                }
              },
              icon: Icon(Icons.minimize),
              label: Text('Sign out'),
            ),),
      
    );
  }
}