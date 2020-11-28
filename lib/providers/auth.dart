import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridabad/data/constants.dart';
import 'package:faridabad/main.dart';
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
  var workCity, workState;
  Map emailList;
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
          currentUser = 'Client';
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

  void generateCity(var stateName,var cityName,var stateC,var cityC) async
  {
    databaseReference.document('DepartmentNames/StateInfo').get().then((value) {
      print('value is ${value.data}');
      var map = value.data;
      var s = map[stateName];
      if(s == null)
      {
        map[stateName] = [cityName];
      }
      else
      {
      s.add(cityName);
      print('s $s');
      map[stateName] = s;
      }
      print('new Value is $map');
      databaseReference.document('DepartmentNames/StateInfo').updateData(map);
      databaseReference.document('DepartmentNames/StateCode').updateData({'$stateC':'$stateName'});
      databaseReference.document('DepartmentNames/CityCode').updateData({'$cityC':'$cityName'});
      generateId(stateC,cityC);
      generateDepartmentNames(stateName, cityName);
    });

    // databaseReference.document('DepartmentNames/StateCode').get().then((value) {
      
    // });
    // 
  }

  void generateId(var stateC,var cityC) {
    List ems = [
      'admin@samadhaan.com',
      'animal@samadhaan.com',
      'bdpo@samadhaan.com',
      'civilh@samadhaan.com',
      'dhbvnr@samadhaan.com',
      'dhbvnu@samadhaan.com',
      'dtownPlanner@samadhaan.com',
      'elementaryedu@samadhaan.com',
      'firedepartment@samadhaan.com',
      'higheredu@samadhaan.com',
      'hvpnl@samadhaan.com',
      'irrigation@samadhaan.com',
      'nagarparishad@samadhaan.com',
      'publicwater@samadhaan.com',
      'pwd@samadhaan.com',
      'socialwelfare@samadhaan.com',
      'tehsil@samadhaan.com',
      'publicswge@samadhaan.com',
      'publicrwell@samadhaan.com'
    ];
    ems.forEach((element) {
      _auth.createUserWithEmailAndPassword(
          email: '$stateC$cityC$element', password: '123456');
    });
  }

  
  void generateDepartmentNames(var stateName,var cityName) {
    List<String> departmentNames = [
    "Animal Husbandry",
    "BDPO",
    "Civil Hospital",
    "DHBVN(Urban)",
    "DHBVN(Rural)",
    "Distt. Town planner",
    "Education(Elementary)",
    "Education(Higher)",
    "Fire Department",
    "HVPNL",
    "Irrigation",
    "Nagar Parishad",
    "PWD",
    "PUBLIC HEALTH(Water)",
    "Public health(Sewage)",
    "Public health (Reny Well)",
    "Social Welfare",
    "Tehsil",
  ];
    departmentNames.forEach((element) {
      databaseReference.document('States/$stateName/$cityName/data/DepartmentNames/names').setData({'Names':departmentNames});
    });
  }

  Future<bool> signIn(String email, String password) async {
    try {
      email = '$email@samadhaan.com';
      print('checking email $email');
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (result.user == null) {
        return false;
      } else {
        user = result.user;
        await checkEmailAndFindUserAndSet(user.email);
        return true;
      }
    } catch (e) {
      print('error logging in!! $e');
      return false;
    }
  }

  Future<void> checkEmailAndFindUserAndSet(String email) async {
    databaseReference.document('DepartmentNames/emails').get().then((value) {
      emailList = value.data['email'];
    }).whenComplete(() {
      var c = email.substring(2, 5);
      var s = email.substring(0, 2);
      email = email.substring(5);
      Map g;
      databaseReference
          .document('DepartmentNames/StateCode')
          .get()
          .then((value) {
        print('check State $s ${value.data[s]}');
        workState = value.data[s];
      }).then((value) {
        databaseReference
            .document('DepartmentNames/CityCode')
            .get()
            .then((value) {
          print('check city $c ${value.data[c]}');
          workCity = value.data[c];
        }).whenComplete(() {
          currentUser = emailList[email];
          setCurrentUser();
        });
      });
    });
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
    // generateCity('UttarPradesh', 'Greater Noida','up','grn');
    // _auth.signOut(); 
    if (await _auth.currentUser() != null) {
      return _auth.currentUser().then((value) async {
        var i = await _auth.fetchSignInMethodsForEmail(email: value.email);
        print(i);
        if (i[0] == 'google.com') {
          currentUser = 'client';
          setCurrentUser();
          return true;
        } else if (i[0] == "password") {
          print(value.email);
          checkEmailAndFindUserAndSet(value.email);
          return true;
        } else {
          return false;
        }
      });
    } else {
      return false;
    }
  }

  void setCurrentUser() async {
    final pref = await SharedPreferences.getInstance();
    pref.setString('currentUser', currentUser);
    if (currentUser != 'client') {
      pref.setString('workCity', workCity);
      pref.setString('workState', workState);
    }
    print('currentUserSet $currentUser');
    print('WorkCitySet $workCity');
    print('WorkStateSet $workState');
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
          var state = doc['state'];
          pref.setString("city", city);
          pref.setString("token", token);
          pref.setString("state", state);
          pref.setString("name", doc['name']);
          print('token $token');
          print('city set $city');
          print('state set $state');
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
