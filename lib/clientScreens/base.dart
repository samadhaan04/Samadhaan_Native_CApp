import 'dart:async';
import 'package:faridabad/data/constants.dart';
import 'package:faridabad/providers/auth.dart';
import 'package:faridabad/clientScreens/filecomplaint.dart';
import 'package:faridabad/loginScreen.dart';
import 'package:faridabad/clientScreens/previouscomplaints.dart';
import 'package:faridabad/clientScreens/user_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Base extends StatefulWidget {
  static const routeName = '/base-screen';

  @override
  _BaseState createState() => _BaseState();
}

class _BaseState extends State<Base> with SingleTickerProviderStateMixin {
  var username;
  var city;
  Widget imageWidget;
  var countNotifications;
  String dropdownValue = '';
  final fbm = FirebaseMessaging();
  var _items = ['User Profile', 'Logout'];

  var image, loading;
  
  
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      loading = true;
    });
    fetchNameAndCity();
    fbm.requestNotificationPermissions();
    fbm.configure(
      onLaunch: (message) {
        print('onLaunch');
        print(message);
        return;
      },
      onMessage: (message) {
        print('onMessage');
        print(message);
        countNotifications++;
        // Fluttertoast.showToast(
        //     msg: "You just recieved a toast notification!!",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.BOTTOM,
        //     timeInSecForIosWeb: 2,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 16.0);
        return;
      },
      onResume: (message) {
        print('onBackgroundMessage');
        print(message);
        // Navigator.of(context).pushNamed(ShowComplaint.routeName,
        //     arguments: message['data']['id']);
        return;
      },
    );
  }

  String getCapitalizeString({String str}) {
    if (str.length <= 1) {
      return str.toUpperCase();
    }
    return '${str[0].toUpperCase()}${str.substring(1)}';
  }

  void fetchNameAndCity() async {
    final storage = FirebaseStorage.instance;
    setState(() {
      loading = true;
    });
    await storage.ref().child('family.jpg').getDownloadURL().then((image) {
      imageWidget = Image.network(
        image,
        width: double.infinity,
        height: 450,
      );
    });
    final pref = await SharedPreferences.getInstance();
    final dname = pref.getString('name');
    print('name $dname');
    city = pref.getString('city');
    print('city $city');
    username = getCapitalizeString(str: dname);
    setState(() {
      loading = false;
    });
    // Auth().burrah();
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

  GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 30,
                        child: SingleChildScrollView(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      '$username',
                                      style: TextStyle(
                                        fontSize: 23.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    DropdownButton(
                                      underline: Container(),
                                      onChanged: (value) async {
                                        setState(() {
                                          dropdownValue = value;
                                        });
                                        if (dropdownValue == 'Logout') {
                                          final signoutResult =
                                              await Auth().signOut();
                                          if (signoutResult) {
                                            Navigator.of(context)
                                                .pushNamedAndRemoveUntil(
                                                    HomeScreen.routeName,
                                                    (route) => false);
                                          }
                                        }
                                        if (dropdownValue == 'User Profile') {
                                          Navigator.of(context).pushNamed(
                                              UserInfoScreen.routeName,
                                              arguments: true);
                                        }
                                      },
                                      icon: Icon(
                                        Icons.menu,
                                        size: 35,
                                      ),
                                      // fit: BoxFit.contain,
                                      // height: 45,
                                      // ),
                                      items: _items.map((e) {
                                        return DropdownMenuItem(
                                          child: Text(e),
                                          value: e,
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                                // Image.asset(
                                //   'assets/images/family.jpg',
                                //   width: _animation.value * 500,
                                // ),
                                imageWidget,
                                brandText,
                                // SizedBox(
                                //   height: 5,
                                // ),
                                Text(
                                  city ?? "empty",
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .37,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                .37,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 1.5)),
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
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    letterSpacing: 1,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            PreviousComplaints.routeName);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(0),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .37,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                .37,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 1.5)),
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
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  "COMPLAINTS",
                                                  style: TextStyle(
                                                      letterSpacing: 1,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
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
