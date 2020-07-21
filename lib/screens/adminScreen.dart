import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  static const routename = '/admin-screen';
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Admin Screen!!'),
      ),
    );
  }
}
