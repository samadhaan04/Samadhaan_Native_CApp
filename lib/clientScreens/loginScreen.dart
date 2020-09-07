import 'package:faridabad/adminScreens/ComplaintScreen.dart';
import 'package:faridabad/main3.dart';
import 'package:faridabad/providers/auth.dart';
import 'package:faridabad/clientScreens/base.dart';
import 'package:faridabad/data/constants.dart';
import 'package:faridabad/adminScreens/departments.dart';
import 'package:faridabad/clientScreens/user_info.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String email;

  String password;

  var height = 0.0;
  var width = 0.0;

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

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
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
                                        if (value.contains('@')) {
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
                                        hintText: 'Email',
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
                                if (_formKey.currentState.validate()) {
                                  print('$email $password');
                                  final result =
                                      await Auth().signIn(email, password);
                                  if (result) {
                                    Navigator.of(context)
                                        .pushReplacementNamed(AdminUi.routeName);
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
