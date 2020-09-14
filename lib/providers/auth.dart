import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridabad/data/constants.dart';
import 'package:faridabad/main.dart';
import 'package:faridabad/providers/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  final _auth = FirebaseAuth.instance;
  final googleSignIn = new GoogleSignIn();
  FirebaseUser user;
  String currentUser;
  Map emailList = emailValue;
  final databaseReference = Firestore.instance;

  Future<bool> signInWithGoogle() async {
    try {
      GoogleSignInAccount googleAccount;

      googleAccount = await googleSignIn.signIn();
      if (googleAccount == null) {
        return false;
      } else {
        final GoogleSignInAuthentication googleauth =
            await googleAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.getCredential(
            idToken: googleauth.idToken, accessToken: googleauth.accessToken);

        AuthResult result = await _auth.signInWithCredential(credential);
        if (result.user == null) {
          return false;
        } else {
          user = result.user;
          // Provider.of<User>(Buildcontext c).setUser('client');
          currentUser = 'client';
          setCurrentUser();
          print('user ${user.uid}');
          print(googleSignIn.currentUser.displayName);
          return true;
        }
      }
    } catch (e) {
      print('error logging in with google');
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (result.user == null) {
        return false;
      } else {
        user = result.user;
        currentUser = checkEmailAndFindUser(user.email);
        setCurrentUser();
        return true;
      }
    } catch (e) {
      print('error logging in!! $e');
      return false;
    }
  }

  String checkEmailAndFindUser(email)
  {
    return emailList[email];
  }

  Future<bool> signOut() async {
    final pref = await SharedPreferences.getInstance();
    try {
      final displayname =
          await _auth.currentUser().then((value) => value.displayName);
      print('$displayname Signed out');
      await googleSignIn.signOut();
      await _auth.signOut();
      currentUser = null;
      pref.clear();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> autoLogin() async {
    if (await _auth.currentUser() != null) {
      return _auth.currentUser().then((value) async {
        var i = await _auth.fetchSignInMethodsForEmail(email: value.email);
        print(i);
        if (i[0] == 'google.com') {
          currentUser = 'client';
          setCurrentUser();
          return true;
        } else if (i[0] == "password") {
          currentUser = checkEmailAndFindUser(value.email);
          setCurrentUser();
          return true;
        }
      });
    } else {
      return false;
    }
  }

  void setCurrentUser() async
  {
    final pref = await SharedPreferences.getInstance();
    pref.setString('currentUser', currentUser);
    print('currentUser set');
  }


  Future<bool> checkuserInfo() async {
    final pref = await SharedPreferences.getInstance();
    final fbm = FirebaseMessaging();
    var token = await fbm.getToken();
    final uid = await _auth.currentUser().then((value) => value.uid);
    try {
      final result = await databaseReference
          .collection('Users')
          .document(uid)
          .get()
          .then((doc) {
        if (doc.exists) {
          var city = doc['city'];
          pref.setString("city", city);
          pref.setString("token", token);
          pref.setString("name", doc['name']);
          print('token $token');
          print('city set $city');
          return true;
        } else {
          return false;
        }
      });
      if (result) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
