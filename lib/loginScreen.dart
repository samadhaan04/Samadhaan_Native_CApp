import 'dart:async';
import 'package:faridabad/adminScreens/adminUI.dart';
import 'package:faridabad/providers/auth.dart';
import 'package:faridabad/clientScreens/base.dart';
import 'package:faridabad/data/constants.dart';
import 'package:faridabad/clientScreens/user_info.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String email;

  String password;

  final _auth = Auth();

  var height = 0.0;
  var width = 0.0;
  var loading = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Future.delayed(Duration(milliseconds: 100)).then((value) => setState(() {
          height = MediaQuery.of(context).size.height;
          width = MediaQuery.of(context).size.width;
        }));
  }

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      key: _scaffoldKey,
      body: loading ? Center(child: CircularProgressIndicator(),) :  Container(
        child: Stack(
          children: <Widget>[
            Center(
              child: AnimatedContainer(
                duration: Duration(seconds: 3),
                curve: Curves.easeInOut,
                height: height,
                width: width,
                child: Hero(
                  tag: 'logo',
                  child: Image.asset('assets/images/samadhaan.png',
                      fit: BoxFit.cover),
                ),
              ),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 30.0,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            brandText,
                            SizedBox(
                              height: 60,
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 40),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 12),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black38, width: 2),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value.length > 5) {
                                          email = value;
                                          print(email);
                                          return null;
                                        } else {
                                          value = null;
                                          return 'please enter valid email';
                                        }
                                      },
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                      decoration: InputDecoration(
                                        border: null,
                                        enabledBorder: InputBorder.none,
                                        hintText: 'Username',
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 40),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.black38, width: 2),
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    child: TextFormField(
                                      obscureText: true,
                                      validator: (value) {
                                        password = value;
                                        return null;
                                      },
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                      decoration: InputDecoration(
                                        enabledBorder: InputBorder.none,
                                        hintText: 'Password',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            RaisedButton(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              color: Colors.grey,
                              onPressed: () async {
                                var user, result;
                                final pref =
                                    await SharedPreferences.getInstance();
                                if (_formKey.currentState.validate()) {
                                  await _auth
                                      .signIn(email, password)
                                      .then((value) {
                                        setState(() {
                                          loading = true;
                                        });
                                    Timer(Duration(milliseconds: 3500), () {
                                      result = value;
                                      user = pref.getString('currentUser');
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
                                    });
                                  });
                                }
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              height: 19,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                    child: Divider(
                                  thickness: 1,
                                  color: Colors.black,
                                )),
                                Text(
                                  "  Or Log in With  ",
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.black),
                                ),
                                Expanded(
                                    child: Divider(
                                  thickness: 1,
                                  color: Colors.black,
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(20),
                              splashColor: Colors.orange,
                              onTap: () async {
                                
                                final result = await Auth().signInWithGoogle();
                                if (result) {
                                  final check = await Auth().checkuserInfo();
                                  print('check $check');
                                  if (check) {
                                    Navigator.of(context)
                                        .pushReplacementNamed(Base.routeName);
                                  } else {
                                    Navigator.of(context).pushReplacementNamed(
                                        UserInfoScreen.routeName);
                                  }
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.black38, width: 1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    FaIcon(
                                      FontAwesomeIcons.google,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      'Sign In With Google',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                // color: Colors.white30,
                              ),
                            ),
                          ],
                        ),
                      ),
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
