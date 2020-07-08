import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridabad/data/constants.dart';
import 'package:faridabad/providers/auth.dart';
import 'package:faridabad/screens/filecomplaint.dart';
import 'package:faridabad/screens/home.dart';
import 'package:faridabad/screens/previouscomplaints.dart';
import 'package:faridabad/screens/showcomplaint.dart';
import 'package:faridabad/screens/user_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Base extends StatefulWidget {
  static const routeName = '/base-screen';

  @override
  _BaseState createState() => _BaseState();
}

class _BaseState extends State<Base> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  var username;
  var city;
  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInCirc);
    _animation.addListener(() => this.setState(() {}));
    _animationController.forward();
    fetchNameAndCity();
  }

  String dropdownValue = '';
  var _items = ['userprofile', 'logout'];

  void fetchNameAndCity() async {
    final pref = await SharedPreferences.getInstance();
    final dname = await FirebaseAuth.instance
        .currentUser()
        .then((value) => value.displayName);
    print('name $dname');
    city = pref.getString('city');
    username = dname;
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit the App'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              FlatButton(
                onPressed: () => SystemNavigator.pop(),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Hello $username'),
                    DropdownButton(
                      underline: Container(),
                      onChanged: (value) async {
                        setState(() {
                          dropdownValue = value;
                        });
                        if (dropdownValue == 'logout') {
                          final signoutResult = await Auth().signOut();
                          if (signoutResult) {
                            Navigator.of(context)
                                .pushReplacementNamed(HomeScreen.routeName);
                          }
                        }
                        if (dropdownValue == 'userprofile') {
                          Navigator.of(context).pushNamed(
                              UserInfoScreen.routeName,
                              arguments: true);
                        }
                      },
                      icon: Image.asset(
                        'assets/images/samadhaan.png',
                        fit: BoxFit.contain,
                        height: 35,
                      ),
                      items: _items.map((e) {
                        return DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        );
                      }).toList(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  flex: 30,
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            "assets/images/family.jpg",
                            width: _animation.value * 500,
                          ),
                          brandText,
                          // SizedBox(
                          //   height: 5,
                          // ),
                          Text(
                            "city",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 38,
                                letterSpacing: 1,
                                color: Colors.blue[300]),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(FileComplaint.routeName);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(0),
                                  width: MediaQuery.of(context).size.width * .4,
                                  height:
                                      MediaQuery.of(context).size.width * .4,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: Colors.black, width: 1)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Icon(
                                        Icons.edit,
                                        color: Colors.black,
                                        size: 50,
                                      ),
                                      Text("FILE COMPLAINT",
                                          style: TextStyle(
                                              letterSpacing: 1,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(PreviousComplanints.routeName);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(0),
                                  width: MediaQuery.of(context).size.width * .4,
                                  height:
                                      MediaQuery.of(context).size.width * .4,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: Colors.black, width: 1)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Icon(
                                        Icons.track_changes,
                                        color: Colors.black,
                                        size: 50,
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            "PREVIOUS",
                                            style: TextStyle(
                                                letterSpacing: 1,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "COMPLAINTS",
                                            style: TextStyle(
                                                letterSpacing: 1,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
