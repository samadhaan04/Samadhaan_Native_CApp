import 'package:flutter/material.dart';

class User extends ChangeNotifier{
  
  String user;

  void setUser(user)
  {
    this.user = user;
    notifyListeners();
  }
  
  String getUser()
  {
    return user;
  }
}