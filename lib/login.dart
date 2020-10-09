import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _otherLogin = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              left: MediaQuery.of(context).size.width * 0.025,
              bottom: MediaQuery.of(context).size.height * 0.18,
              child: AnimatedContainer(
                duration: Duration(seconds: 3),
                curve: Curves.easeInOut,
                height: MediaQuery.of(context).size.height * 1.1,
                width: MediaQuery.of(context).size.width * 0.95,
                child: Hero(
                  tag: 'logo',
                  child: Image.asset(
                    'assets/images/phone-image.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 370),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  Text(
                    'Samadhaan',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff404543),
                    ),
                  ),
                  SizedBox(
                    height: 10,
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
                              height: 40,
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
                              height: 30,
                            ),
                            Image.asset(
                              'assets/images/google.png',
                              height: 60,
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            FlatButton(
                              child: Text(
                                'Admin and Department Login',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff404543),
                                  fontSize: 16,
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
                      : Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 30, bottom: 4),
                              padding: EdgeInsets.only(
                                left: 20,
                                top: 6,
                                bottom: 6,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: null,
                                  enabledBorder: InputBorder.none,
                                  hintText: 'Email',
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(12),
                              padding: EdgeInsets.only(
                                left: 20,
                                top: 6,
                                bottom: 6,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: null,
                                  enabledBorder: InputBorder.none,
                                  hintText: 'Password',
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: RaisedButton(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                elevation: 5,
                                color: Colors.blueGrey[800],
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 18,
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                onPressed: () {},
                              ),
                            )
                          ],
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
