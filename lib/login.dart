import 'package:flutter/material.dart';
import 'package:faridabad/providers/auth.dart';
import 'package:faridabad/clientScreens/base.dart';
import 'package:faridabad/clientScreens/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:faridabad/adminScreens/adminUI.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Login extends StatefulWidget {
  static const routeName = '/Login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _otherLogin = true;
  var loading = false;
  String email;
  final _auth = Auth();
  String password;
  // final storage = FirebaseStorage.instance;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var h,w;
  // Widget imageWidget;

  // void getloginImage() async {
  //   await storage.ref().child('loginImage.png').getDownloadURL().then((image) {
  //     setState(() {
  //       imageWidget = Container(
  //         height: MediaQuery.of(context).size.height * 0.4,
  //         child: Image.network(
  //           image,
  //           width: MediaQuery.of(context).size.width * 0.85,
  //         ),
  //       );
  //     });
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   getloginImage();
  // }



  void showSnackbar(var message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          'Please Enter Valid Details',
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w =  MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
            child: Column(
                children: <Widget>[

                    AnimatedContainer(
                      margin: EdgeInsets.only(top: h*0.01),
                      duration: Duration(seconds: 3),
                      curve: Curves.easeInOut,
                      height: h * 0.38,
                      width: w * 0.95,
                      child: Hero(
                        tag: 'logo',
                        child: Image.asset(
                          'assets/images/loginImage.png',
                          fit: BoxFit.contain,
                        ),
                    ),
                  ),
                  Container(
                    height: h * 0.61,
                    width: w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: h*0.1,
                        ),
                        Text(
                          'Samadhaan',
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff404543),
                          ),
                        ),
                        SizedBox(
                          height: h*0.02,
                        ),
                        Text(
                          'Smart Administration for',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: Color(0xff404543),
                          ),
                        ),
                        Text(
                          'Smart Cities',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: Color(0xff404543),
                          ),
                        ),
                        _otherLogin
                            ? Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: h*0.04,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Expanded(
                                        child: Divider(
                                          color: Color(0xff404543),
                                          thickness: 1.2,
                                        ),
                                      ),
                                      Text(
                                        ' Log In with ',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff404543),
                                        ),
                                      ),
                                      Expanded(
                                        child: Divider(
                                          color: Color(0xff404543),
                                          thickness: 1.2,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 25,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: h*0.03,
                                  ),
                                  GestureDetector(
                                    child: Image.asset(
                                      'assets/images/google.png',
                                      height: h*0.06,
                                    ),
                                    onTap: () async {
                                      setState(() {
                                        loading = true;
                                      });
                                      final result =
                                          await Auth().signInWithGoogle();
                                      if (result) {
                                        final check =
                                            await Auth().checkuserInfo();
                                        print('check $check');
                                        if (check) {
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  Base.routeName);
                                        } else {
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  UserInfoScreen.routeName);
                                        }
                                        setState(() {
                                          loading = false;
                                        });
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: h*0.03,
                                  ),
                                  FlatButton(
                                    child: Text(
                                      'Admin and Department Login',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff404543),
                                        fontSize: 18,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _otherLogin = false;
                                      });
                                    },
                                  ),
                                ],
                              )
                            : Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 20, bottom: 4),
                                      padding: EdgeInsets.only(
                                        left: 20,
                                        top: 6,
                                        bottom: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value.length > 5) {
                                            email = value;
                                            print(email);
                                            return null;
                                          } else {
                                            value = null;
                                            return 'length should be greater than 5';
                                          }
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Username',
                                        ),
                                      ),
                                      // TextFormField(

                                      //   decoration: InputDecoration(
                                      //     border: null,
                                      //     enabledBorder: InputBorder.none,
                                      //     hintText: 'Username',
                                      //   ),
                                      // ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(h*0.01),
                                      padding: EdgeInsets.only(
                                        left: 20,
                                        top: 6,
                                        bottom: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: TextFormField(
                                        obscureText: true,
                                        validator: (value) {
                                          password = value;
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Password',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: RaisedButton(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        elevation: 5,
                                        color: Colors.blueGrey[800],
                                        child: Text(
                                          'Login',
                                          style: TextStyle(
                                            color: Colors.grey[400],
                                            fontSize: 18,
                                          ),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        onPressed: () async {
                                          var user, result;
                                          final pref = await SharedPreferences
                                              .getInstance();
                                          if (_formKey.currentState
                                              .validate()) {
                                            await _auth
                                                .signIn(email, password)
                                                .then((value) {
                                              setState(() {
                                                loading = true;
                                              });
                                              Timer(
                                                  Duration(milliseconds: 3500),
                                                  () {
                                                result = value;
                                                user = pref
                                                    .getString('currentUser');
                                                print(user);
                                                if (result == true) {
                                                  print('login $user');
                                                  setState(() {
                                                    loading = false;
                                                  });
                                                  Navigator.of(context)
                                                      .pushReplacementNamed(
                                                          AdminUi.routeName,
                                                          arguments: user);
                                                } else {
                                                  showSnackbar(
                                                    'Please Enter Valid Details',
                                                  );
                                                  setState(() {
                                                    loading = false;
                                                  });
                                                }
                                              });
                                            });
                                          } else {
                                            showSnackbar(
                                              'Please Enter Valid Details',
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: h*0.01,
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      alignment: Alignment.centerRight,
                                      child: FlatButton(
                                        child: Text('Go Back'),
                                        onPressed: () {
                                          setState(() {
                                            _otherLogin = !_otherLogin;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
          ),
    );
  }
}
