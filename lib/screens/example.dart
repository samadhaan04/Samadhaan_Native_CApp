import 'package:faridabad/providers/auth.dart';
import 'package:faridabad/screens/filecomplaint.dart';
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
            RaisedButton.icon(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Colors.black,
              elevation: 10,
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
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
              icon: Icon(
                Icons.minimize,
                color: Colors.white,
              ),
              label: const Text(
                'Sign out',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Colors.black,
              elevation: 10,
              onPressed: () {
                Navigator.of(context).pushNamed(FileComplaint.routeName);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 8,
                ),
                child: const Text(
                  'File Complaint',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Colors.black,
              elevation: 10,
              onPressed: () {
                Navigator.of(context).pushNamed(ShowComplaint.routeName);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 8,
                ),
                child: const Text(
                  'Show Complaint',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
