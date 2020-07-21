import 'package:faridabad/providers/auth.dart';
import 'package:faridabad/screens/adminScreen.dart';
import 'package:faridabad/screens/base.dart';
import 'package:faridabad/screens/example.dart';
import 'package:faridabad/data/constants.dart';
import 'package:faridabad/screens/user_info.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  String email;
  String password;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                      // Hero(
                      //   tag: 'logo',
                      //   child: Container(
                      //     height: 250.0,
                      //     width: 250.0,
                      //     child: Image.asset(
                      //       'assets/images/samadhaan.png',
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      brandText,
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 40),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black,
                                      spreadRadius: 1,
                                      blurRadius: 10)
                                ],
                                borderRadius: BorderRadius.circular(35),
                              ),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.contains('@')) {
                                    print('email id fine');
                                    email = value;
                                    print(email);
                                    return null;
                                  } else {
                                    print('not fine');
                                    return value;
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
                              margin: EdgeInsets.symmetric(horizontal: 40),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black,
                                      spreadRadius: 1,
                                      blurRadius: 10)
                                ],
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
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        color: Colors.redAccent,
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            print('$email $password');
                            final result = await Auth().signIn(email, password);
                            if (result) {
                              Navigator.of(context)
                                  .pushNamed(AdminScreen.routename);
                            }
                          }
                        },
                        child: Text('Login'),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text("OR"),
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
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black,
                                  spreadRadius: 1,
                                  blurRadius: 10)
                            ],
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
    );
  }
}
