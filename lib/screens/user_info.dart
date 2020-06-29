import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridabad/data/constants.dart';
import 'package:faridabad/screens/base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dart:io';

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
  TextEditingController _colonyController = new TextEditingController();
  TextEditingController _ageController = new TextEditingController();
  String _wardNumber;
  String _village;
  String _gender;
  var uid;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  // PersistentBottomSheetController _controller;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  
  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _houseController.dispose();
    _colonyController.dispose();
    _ageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  bool loading = false;
  callback(bool value) {
    setState(() {
      loading = value;
    });
  }

  @override
  void initState()  {
    super.initState();
    
  fetchData();
      print('gender $_gender');
    checkInternet();
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 600));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInCirc);
    _animation.addListener(() => this.setState(() {}));
    _animationController.forward();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    isupdate = ModalRoute.of(context).settings.arguments ?? false;
    if (isupdate) {
      await fetchData();
      print('gender $_gender');
    }
   uid = await _auth.currentUser().then((value) => value.uid);
  }

  @override
  Widget build(BuildContext context) {
    print('gender hai -> $_gender');
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
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
                  StreamBuilder(
                    stream: Firestore.instance.collection('Users').document(uid).snapshots(),
                    builder: (context, snapshot) {
                      print(snapshot);
                      if(snapshot.connectionState == ConnectionState.waiting)
                      {
                        return CircularProgressIndicator();
                      }
                      print(snapshot.data['ward no'].toString());
                      return Form(
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
                                    borderRadius: BorderRadius.circular(20)),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  autocorrect: false,
                                  controller: _nameController,
                                  maxLines: 1,
                                  validator: (value) {
                                    if (value.isEmpty || value.length < 1) {
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
                                    borderRadius: BorderRadius.circular(20)),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  autocorrect: false,
                                  controller: _phoneController,
                                  maxLines: 1,
                                  validator: (value) {
                                    if (value.isEmpty ||
                                        value.length < 1 && value.length > 10 ||
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
                                    borderRadius: BorderRadius.circular(20)),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  autocorrect: false,
                                  controller: _ageController,
                                  maxLines: 1,
                                  validator: (value) {
                                    if (value.isEmpty || int.parse(value) < 10) {
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
                                    borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                          fontSize: 15, color: Colors.grey[600]),
                                      elevation: 2,
                                      hint: Text(
                                        'Gender',
                                        style: TextStyle(
                                            decorationStyle:
                                                TextDecorationStyle.solid),
                                      ), 
                                      value: _gender ?? null,
                                      onChanged: (newValue) {
                                        setState(() {
                                          if (newValue == "None") {
                                            _gender = 'null';
                                          } else {
                                            _gender = newValue;
                                          }
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
                                    borderRadius: BorderRadius.circular(20)),
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
                                    borderRadius: BorderRadius.circular(20)),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  autocorrect: false,
                                  controller: _colonyController,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                      icon: Icon(
                                        Icons.location_city,
                                        size: 40,
                                        color: Colors.black,
                                      ),
                                      enabledBorder: InputBorder.none,
                                      labelText: 'Colony',
                                      hintText: "Enter your Colony",
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
                                    borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                          fontSize: 15, color: Colors.grey[600]),
                                      elevation: 2,
                                      value: _wardNumber,
                                      onChanged: (newValue) {
                                        setState(() {
                                          if (newValue == "None") {
                                            _wardNumber = null;
                                          } else {
                                            _wardNumber = newValue;
                                            _village = null;
                                          }
                                        });
                                      },
                                      items: getWardsList().map((value) {
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
                                    borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                          fontSize: 15, color: Colors.grey[600]),
                                      elevation: 2,
                                      hint: Text(
                                        'Village',
                                        style: TextStyle(color: Colors.grey),
                                      ), // Not necessary for Option 1
                                      value: _village ?? null,
                                      onChanged: (newValue) {
                                        setState(() {
                                          if (newValue == "None") {
                                            _village = null;
                                          } else {
                                            _village = newValue;
                                            _wardNumber = null;
                                          }
                                        });
                                      },
                                      items: villages.map((location) {
                                        return DropdownMenuItem(
                                          child: new Text(location),
                                          value: location,
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              // Container(
                              //   width: double.infinity,
                              //   padding: EdgeInsets.all(8),
                              //   decoration: BoxDecoration(
                              //       color: Colors.black,
                              //       borderRadius: BorderRadius.circular(20)),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.start,
                              //     children: <Widget>[
                              //       Icon(
                              //         Icons.assignment,
                              //         size: 40,
                              //         color: Colors.white,
                              //       ),
                              //       SizedBox(
                              //         width: 18,
                              //       ),
                              //       DropdownButton(
                              //         iconEnabledColor: Colors.white,
                              //         underline: Container(
                              //           color: Colors.transparent,
                              //         ),
                              //         focusColor: Colors.black,
                              //         style: TextStyle(
                              //             fontSize: 15, color: Colors.grey[600]),
                              //         elevation: 2,
                              //         hint: Text(
                              //           'Department ',
                              //           style: TextStyle(color: Colors.grey),
                              //         ), // Not necessary for Option 1
                              //         value: _selectedDepartment,
                              //         onChanged: (newValue) {
                              //           setState(() {
                              //             _selectedDepartment = newValue;
                              //           });
                              //         },
                              //         items: depts.map((location) {
                              //           return DropdownMenuItem(
                              //             child: new Text(location),
                              //             value: location,
                              //           );
                              //         }).toList(),
                              //       ),
                              //     ],
                              //   ),
                              // ),
//                          SizedBox(
//                            height: 10,
//                          ),
//                          Container(
//                            width: double.infinity,
//                            padding: EdgeInsets.all(8),
//                            decoration: BoxDecoration(
//                                color: Colors.grey[300],
//                                borderRadius: BorderRadius.circular(20)),
//                            child: TextFormField(
//                              keyboardType: TextInputType.text,
//                              autocorrect: false,
//                              controller: _consumerController,
//                              maxLines: 1,
//                              //validator: (value) {},
//                              decoration: InputDecoration(
//                                  icon: Icon(
//                                    Icons.person_outline,
//                                    size: 40,
//                                    color: Colors.black,
//                                  ),
//                                  enabledBorder: InputBorder.none,
//                                  labelText: 'Consumer Id',
//                                  hintText: "Enter a Consumer Id",
//                                  labelStyle: TextStyle(
//                                      decorationStyle:
//                                          TextDecorationStyle.solid)),
//                            ),
//                          ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              // Container(
                              //   width: double.infinity,
                              //   padding: EdgeInsets.all(8),
                              //   decoration: BoxDecoration(
                              //       color: Colors.grey[300],
                              //       borderRadius: BorderRadius.circular(20)),
                              //   child: TextFormField(
                              //     keyboardType: TextInputType.text,
                              //     autocorrect: false,
                              //     controller: _detailsController,
                              //     maxLines: null,
                              //     validator: (value) {
                              //       if (value.isEmpty || value.length < 1) {
                              //         return 'Please enter details about your issue';
                              //       }
                              //       return null;
                              //     },
                              //     decoration: InputDecoration(
                              //         icon: Icon(
                              //           Icons.edit,
                              //           size: 40,
                              //           color: Colors.black,
                              //         ),
                              //         enabledBorder: InputBorder.none,
                              //         labelText: 'Details of the Issue',
                              //         hintText:
                              //             "Enter all the details about the issue",
                              //         labelStyle: TextStyle(
                              //             decorationStyle:
                              //                 TextDecorationStyle.solid)),
                              //   ),
                              // ),
                              SizedBox(
                                height: 15,
                              ),
                              MaterialButton(
                                padding: EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 38),
                                color: Colors.black,
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
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
                                  if ((_wardNumber == null && _village == null)) {
                                    showDialog(
                                        context: context,
                                        child: AlertDialog(
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          title: Text(
                                            "TRY AGAIN",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          content: Text(
                                              "Either Ward Number or Village is mandatory"),
                                          actions: <Widget>[
                                            MaterialButton(
                                              child: Text(
                                                "RETRY",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            )
                                          ],
                                        ));
                                  } else if (!(_formkey.currentState.validate())) {
                                    showDialog(
                                        context: context,
                                        child: AlertDialog(
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          title: Text(
                                            "TRY AGAIN",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          content:
                                              Text("Please Check Your Detials"),
                                          actions: <Widget>[
                                            MaterialButton(
                                              child: Text(
                                                "RETRY",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
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
                                                    BorderRadius.circular(20)),
                                            title: Text(
                                              "TRY AGAIN",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            content: Text(
                                                "Please Check Your Internet Connection"),
                                            actions: <Widget>[
                                              MaterialButton(
                                                child: Text(
                                                  "RETRY",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
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
                                          _colonyController.clear();
                                          _village = null;
                                          _gender = null;
                                          _wardNumber = null;
                                        });
                                        Navigator.of(context)
                                            .pushReplacementNamed(Base.routeName);
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
                              // SizedBox(
                              //   height: 10,
                              // ),
                              // loading ? CircularProgressIndicator() : Container(),
                              // SizedBox(
                              //   height: 10,
                              // ),
                            ],
                          ),
                        ),
                      );
                    }
                  ),
                ],
              ),
            ),
          ),
        ));
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
    _wardNumber = (result['ward no']).toString();
    _nameController.text = result['name'];
    _ageController.text = (result['Age']).toString();
    _colonyController.text = result['colony'];
    _houseController.text = result['house no'];
    _gender = result['Gender'];
    _phoneController.text = (result['phone']);
    _village = result['village'];
    
    print(_gender);
    print(_wardNumber);
    print(_village);
    return true;
  }

  Future<bool> sendData(bool isupdate) async {
    try {
      final uid = await _auth.currentUser().then((value) => value.uid);
      if (isupdate) {
        await databaseReference.collection("Users").document(uid).updateData({
          'name': _nameController.text,
          'phone': _phoneController.text,
          'Age': int.parse(_ageController.text),
          'Gender': _gender,
          'house no': _houseController.text,
          'colony': _colonyController.text,
          'ward no': _wardNumber == null ? null : int.parse(_wardNumber),
          'village': _village == null ? null : _village,
        }).then((value) {
          print("Success");
          return true;
        });
        return true;
      } else {
        await databaseReference.collection("Users").document(uid).setData({
          'name': _nameController.text,
          'phone': _phoneController.text,
          'Age': int.parse(_ageController.text),
          'Gender': _gender,
          'house no': _houseController.text,
          'colony': _colonyController.text,
          'ward no': _wardNumber == null ? null : int.parse(_wardNumber),
          'village': _village == null ? null : _village,
        }).then((value) {
          print("Success");
          return true;
        });
        return true;
      }
    } catch (e) {
      print(e);
      print('please try again');
      return false;
    }
  }
}
