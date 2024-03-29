import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridabad/data/constants.dart';
import 'package:faridabad/clientScreens/base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class UserInfoScreen extends StatefulWidget {
  static const routeName = '/user-info';

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen>
    with SingleTickerProviderStateMixin {
  final databaseReference = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  bool isupdate = false;

  AnimationController _animationController;
  Animation<double> _animation;
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _houseController = new TextEditingController();
  TextEditingController _streetController = new TextEditingController();
  TextEditingController _ageController = new TextEditingController();
  String _state;
  String _constituency;
  String _gender;
  bool _init = true;
  var uid;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  // PersistentBottomSheetController _controller;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  var _chosenOption = '';

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _houseController.dispose();
    _streetController.dispose();
    _ageController.dispose();
    _animationController.dispose();
  }

  bool loading = false;
  List<String> states = [];
  Map cityMap;
  List cities = [];
  var loadingcity = false;

  callback(bool value) {
    setState(() {
      loading = value;
    });
  }

  @override
  void initState() {
    super.initState();
    checkInternet();
    _animationController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInCirc);
    _animation.addListener(() => this.setState(() {}));
    _animationController.forward();
    getStates();
  }

  void getStates() {
    setState(() {
      loading = true;
    });
    databaseReference.document('DepartmentNames/StateInfo').get().then((value) {
      setState(() {
        states = value.data.keys.toList();
        cityMap = value.data;
        print(cityMap);
        states.insert(0, 'None');
        print(states);
        getcities();
      });
    });
  }

  void getcities() {
    setState(() {
      loadingcity = true;
    });
      setState(() {
        print('state $_state');
        if (_state != null)
          cities = cityMap[_state];
        else
          cities = ['None'];
        print(cities);
        loadingcity = false;
        loading = false;
      });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_init) {
      setState(() {
        loading = true;
      });
      isupdate = ModalRoute.of(context).settings.arguments ?? false;
      if (isupdate) {
        final result = await fetchData();
        print('fetched data');
        if (result) {}
      }
      setState(() {
        loading = false;
      });
      _init = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body:
          // loadingcity ? Stack(
          //   children: [
          //     Center(child: CircularProgressIndicator(),),
          //     ],
          //     ) :
          Stack(
        children: [
          Opacity(
            opacity: loadingcity ? 0.5 : 1.0,
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                      ),
                      Image.asset(
                        "assets/images/edit.jpg",
                        width: _animation.value * 350,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      loading
                          ? CircularProgressIndicator()
                          : Form(
                              key: _formkey,
                              child: Container(
                                padding: EdgeInsets.all(25),
                                child: Column(
                                  children: <Widget>[
                                    userInfoText,
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        autocorrect: false,
                                        controller: _nameController,
                                        maxLines: 1,
                                        validator: (value) {
                                          if (value.isEmpty ||
                                              value.length < 1) {
                                            return 'Please enter your name';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            icon: Icon(
                                              Icons.person,
                                              size: 40,
                                              color: Colors.black,
                                            ),
                                            enabledBorder: InputBorder.none,
                                            labelText: 'Name',
                                            hintText: "Enter your name",
                                            labelStyle: TextStyle(
                                                decorationStyle:
                                                    TextDecorationStyle.solid)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        autocorrect: false,
                                        controller: _phoneController,
                                        maxLines: 1,
                                        validator: (value) {
                                          if (value.isEmpty ||
                                              value.length < 1 &&
                                                  value.length > 10 ||
                                              int.parse(value) < 5555555555) {
                                            return 'Please enter a valid phone number';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            icon: Icon(
                                              Icons.phone,
                                              size: 40,
                                              color: Colors.black,
                                            ),
                                            enabledBorder: InputBorder.none,
                                            labelText: 'Phone',
                                            hintText: "Enter your phone number",
                                            labelStyle: TextStyle(
                                                decorationStyle:
                                                    TextDecorationStyle.solid)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        autocorrect: false,
                                        controller: _ageController,
                                        maxLines: 1,
                                        validator: (value) {
                                          if (value.isEmpty ||
                                              int.parse(value) < 10) {
                                            return 'Age Must Be Greater Than 10';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            icon: Icon(
                                              Icons.perm_contact_calendar,
                                              size: 40,
                                              color: Colors.black,
                                            ),
                                            enabledBorder: InputBorder.none,
                                            labelText: 'Age',
                                            hintText: "Enter your Age",
                                            labelStyle: TextStyle(
                                                decorationStyle:
                                                    TextDecorationStyle.solid)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Icon(
                                            Icons.assignment,
                                            size: 40,
                                            color: Colors.black,
                                          ),
                                          SizedBox(
                                            width: 18,
                                          ),
                                          DropdownButton(
                                            iconEnabledColor: Colors.black,
                                            underline: Container(
                                              color: Colors.transparent,
                                            ),
                                            focusColor: Colors.white,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey[600]),
                                            elevation: 2,
                                            hint: Text(
                                              'Gender',
                                              style: TextStyle(
                                                  decorationStyle:
                                                      TextDecorationStyle
                                                          .solid),
                                            ),
                                            value: _gender,
                                            onChanged: (newValue) {
                                              setState(() {
                                                _gender = newValue;
                                              });
                                            },
                                            items: gender.map((location) {
                                              return DropdownMenuItem(
                                                child: new Text(location),
                                                value: location,
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        autocorrect: false,
                                        controller: _houseController,
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                            icon: Icon(
                                              Icons.home,
                                              size: 40,
                                              color: Colors.black,
                                            ),
                                            enabledBorder: InputBorder.none,
                                            labelText: 'House No.',
                                            hintText: "Enter your House Number",
                                            labelStyle: TextStyle(
                                                decorationStyle:
                                                    TextDecorationStyle.solid)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        autocorrect: false,
                                        controller: _streetController,
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                            icon: Icon(
                                              Icons.location_city,
                                              size: 40,
                                              color: Colors.black,
                                            ),
                                            enabledBorder: InputBorder.none,
                                            labelText: 'Street',
                                            hintText: "Enter your Street",
                                            labelStyle: TextStyle(
                                                decorationStyle:
                                                    TextDecorationStyle.solid)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Icon(
                                            Icons.confirmation_number,
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 18,
                                          ),
                                          DropdownButton(
                                            iconEnabledColor: Colors.white,
                                            underline: Container(
                                              color: Colors.transparent,
                                            ),
                                            focusColor: Colors.black,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey[600]),
                                            elevation: 2,
                                            hint: Text(
                                              'State',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                            value: _state ?? null,
                                            onChanged: (newValue) {
                                              _constituency = null;
                                              setState(() {
                                                if (newValue == "None") {
                                                  _state = null;
                                                } else {
                                                  _state = newValue;
                                                }
                                                getcities();
                                              });
                                            },
                                            items: states.map((value) {
                                              return DropdownMenuItem(
                                                child: Text(value),
                                                value: value,
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Icon(
                                            Icons.assignment,
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 18,
                                          ),
                                          DropdownButton(
                                            iconEnabledColor: Colors.white,
                                            underline: Container(
                                              color: Colors.transparent,
                                            ),
                                            focusColor: Colors.black,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey[600]),
                                            elevation: 2,
                                            hint: Text(
                                              'city',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ), // Not necessary for Option 1
                                            value: _constituency ?? null,
                                            onChanged: loadingcity
                                                ? null
                                                : (newValue) {
                                                    setState(() {
                                                      if (newValue == "None") {
                                                        _constituency = null;
                                                      } else {
                                                        _constituency =
                                                            newValue;
                                                      }
                                                    });
                                                  },
                                            items: cities.map((location) {
                                              return DropdownMenuItem(
                                                child: new Text(location),
                                                value: location,
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    MaterialButton(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 16, horizontal: 38),
                                      color: Colors.black,
                                      textColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: loading
                                          ? Center(
                                              child: CircularProgressIndicator(
                                                backgroundColor: Colors.white,
                                              ),
                                            )
                                          : Text(
                                              "SUBMIT",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                      onPressed: () async {
                                        if ((_state == null ||
                                            _constituency == null)) {
                                          showDialog(
                                              context:
                                                  scaffoldKey.currentContext,
                                              child: AlertDialog(
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                title: Text(
                                                  "TRY AGAIN",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                content: Text(
                                                    "State and city is mandatory"),
                                                actions: <Widget>[
                                                  MaterialButton(
                                                    child: Text(
                                                      "RETRY",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  )
                                                ],
                                              ));
                                        } else if (!(_formkey.currentState
                                            .validate())) {
                                          showDialog(
                                              context: context,
                                              child: AlertDialog(
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                title: Text(
                                                  "TRY AGAIN",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                content: Text(
                                                    "Please Check Your Detials"),
                                                actions: <Widget>[
                                                  MaterialButton(
                                                    child: Text(
                                                      "RETRY",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  )
                                                ],
                                              ));
                                        } else {
                                          setState(() {
                                            loading = true;
                                          });
                                          // responeTimer();
                                          bool result = await checkInternet();
                                          if (!result) {
                                            print('result checked $result');
                                            setState(() {
                                              loading = false;
                                            });

                                            showDialog(
                                                context: context,
                                                child: AlertDialog(
                                                  backgroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  title: Text(
                                                    "TRY AGAIN",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  content: Text(
                                                      "Please Check Your Internet Connection"),
                                                  actions: <Widget>[
                                                    MaterialButton(
                                                      child: Text(
                                                        "RETRY",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    )
                                                  ],
                                                ));
                                          } else {
                                            final userinforesult =
                                                await sendData(isupdate);
                                            print(userinforesult);
                                            if (userinforesult) {
                                              setState(() {
                                                _nameController.clear();
                                                _phoneController.clear();
                                                _houseController.clear();
                                                _ageController.clear();
                                                _streetController.clear();
                                                _constituency = null;
                                                _gender = null;
                                                _state = null;
                                              });
                                              Navigator.of(context)
                                                  .pushReplacementNamed(
                                                      Base.routeName);
                                            } else {
                                              print('not done');
                                            }
                                          }
                                          setState(() {
                                            loading = false;
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Opacity(
            opacity: loadingcity ? 1.0 : 0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }

  void showModal(context, List<dynamic> options) {
    showModalBottomSheet(
        isScrollControlled: false,
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return Container(
            height: 300,
            child: Column(
              children: [
                Container(
                  child: FlatButton(
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Done",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blueAccent,
                      ),
                    ),
                    shape: CircleBorder(
                        side: BorderSide(
                      color: Colors.transparent,
                    )),
                  ),
                ),
                Expanded(
                  child: CupertinoPicker(
                    magnification: 1.5,
                    diameterRatio: 100.0,
                    scrollController:
                        FixedExtentScrollController(initialItem: 5),
                    backgroundColor: Color(0xffd0d5da),
                    children: List<Widget>.generate(
                      options.length,
                      (index) => Center(
                        child: Text(
                          options[index],
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    itemExtent: 50, //height of each item
                    looping: false,
                    onSelectedItemChanged: (int index) {
                      setState(() {
                        _chosenOption = options[index];
                        print(_chosenOption);
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  void responeTimer() async {
    print('timer fired');
    await Future.delayed(Duration(seconds: 10))
        .then((value) => callback(false));
  }

  Future<bool> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        return true;
      }
    } on SocketException catch (_) {
      print('not connected');
      return false;
    }
    return false;
  }

  Future<bool> fetchData() async {
    final uid = await _auth.currentUser().then((value) => value.uid);
    final data = Firestore.instance.collection('Users').document(uid);
    final result = await data.get();
    _state = result['state'] == null ? null : result['state'];
    _nameController.text = result['name'];
    _ageController.text = (result['age']).toString();
    _streetController.text = result['street'];
    _houseController.text = result['houseNumber'];
    _gender = result['gender'];
    _phoneController.text = (result['phoneNumber']);
    _constituency = result['city'];
    getcities();
    return true;
  }

  Future<bool> sendData(bool isupdate) async {
    final pref = await SharedPreferences.getInstance();
    try {
      final uid = await _auth.currentUser().then((value) => value.uid);
      if (isupdate) {
        await databaseReference.collection("Users").document(uid).updateData({
          'name': _nameController.text,
          'phoneNumber': _phoneController.text,
          'age': int.parse(_ageController.text),
          'gender': _gender,
          'houseNumber': _houseController.text,
          'street': _streetController.text,
          'state': _state == null ? null : _state,
          'city': _constituency == null ? null : _constituency,
        }).then((value) {
          pref.setString('city', _constituency);
          pref.setString("name", _nameController.text);
          pref.setString("state", _state);
          print("Success");
          return true;
        });
        return true;
      } else {
        var ref =
            await databaseReference.collection("Users").document(uid).setData({
          'name': _nameController.text,
          'phoneNumber': _phoneController.text,
          'age': int.parse(_ageController.text),
          'gender': _gender,
          'houseNumber': _houseController.text,
          'street': _streetController.text,
          'state': _state == null ? null : _state,
          'city': _constituency == null ? null : _constituency,
        });
        pref.setString('city', _constituency);
        pref.setString("name", _nameController.text);
        print("Success");
        var path = Firestore.instance.collection('Users').document(uid).path;
        print(path);
        databaseReference
            .collection("States/$_state/$_constituency/Users/users")
            .add({"user": path});
        return true;
      }
    } catch (e) {
      print(e);
      print('please try again');
      return false;
    }
  }
}
