import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridabad/widgets/modalSheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FileComplaint extends StatefulWidget {
  static const routeName = 'file-complaint';

  @override
  _FileComplaintState createState() => _FileComplaintState();
}

class _FileComplaintState extends State<FileComplaint>
    with SingleTickerProviderStateMixin {
  final databaseReference = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  bool isupdate = false;
  bool loading = false;
  callback(bool value) {
    setState(() {
      loading = value;
    });
  }

  @override
  void dispose() {
    _detailsController.dispose();
    super.dispose();
  }

  TextEditingController _detailsController = new TextEditingController();
  String _department;
  File _image;
  final List<String> depts = [
    "None",
    "Animal Husbandry",
    "BDPO",
    "Civil Hospital",
    "DHBVN(Urban)",
    "DHBVN(Rural)",
    "Distt. Town planner ",
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
    "Tehsil"
  ];

  void showModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ModalSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'File ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                          ),
                        ),
                        Text(
                          'Complaint',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 50,
                              color: Colors.teal[200]),
                        ),
                      ],
                    ),
                  ),
                  // TO BE DONE: Render a custom image from backend
                  SizedBox(
                    height: 200,
                  ),
                  Text(
                    'Samadhaan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Faridabad',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Colors.teal[200],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 50,
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
                          style:
                              TextStyle(fontSize: 15, color: Colors.grey[600]),
                          elevation: 2,
                          hint: Text(
                            'Department ',
                            style: TextStyle(color: Colors.grey),
                          ), // Not necessary for Option 1
                          value: _department,
                          onChanged: (newValue) {
                            setState(() {
                              _department = newValue;
                            });
                          },
                          items: depts.map((location) {
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
                      controller: _detailsController,
                      maxLines: null,
                      validator: (value) {
                        if (value.isEmpty || value.length < 1) {
                          return 'Please enter details about your issue';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.edit,
                            size: 40,
                            color: Colors.black,
                          ),
                          enabledBorder: InputBorder.none,
                          labelText: 'Details of the Issue',
                          hintText: "Enter all the details about the issue",
                          labelStyle: TextStyle(
                              decorationStyle: TextDecorationStyle.solid)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          child: AlertDialog(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            title: Text(
                              "Choose an Option",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            actions: <Widget>[
                              MaterialButton(
                                child: Text(
                                  "Gallery",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                onPressed: () async {
                                  final picker = ImagePicker();
                                  final pickedImage = await picker.getImage(
                                      source: ImageSource.gallery,
                                      imageQuality: 60,
                                      maxWidth: 150);
                                  setState(() {
                                    _image = File(pickedImage.path);
                                  });

                                  Navigator.of(context).pop();
                                },
                              ),
                              MaterialButton(
                                child: Text(
                                  "Camera",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                onPressed: () async {
                                  final picker = ImagePicker();
                                  final pickedImage = await picker.getImage(
                                      source: ImageSource.camera,
                                      imageQuality: 60,
                                      maxWidth: 150);
                                  setState(() {
                                    _image = File(pickedImage.path);
                                  });

                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          ));
                    },
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Image',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  _image != null ? FileImage(_image) : null,
                            )
                          ],
                        ),
                      ),
                      elevation: 5,
                      color: Colors.greenAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(100, 10, 100, 10),
                    child: RaisedButton(
                      padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        {
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
                                      borderRadius: BorderRadius.circular(20)),
                                  title: Text(
                                    "TRY AGAIN",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                            await sendData();
                          }
                          setState(() {
                            loading = false;
                          });
                        }
                        showModalSheet(context);
                      },
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
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

  Future<void> sendData() async {
    try {
      final uid = await _auth.currentUser().then((value) => value.uid);
      final ref2 = FirebaseStorage.instance
          .ref()
          .child('complaintImages')
          .child(uid + DateTime.now().toIso8601String() + '.jpg');
      await ref2.putFile(_image).onComplete;
      final url = await ref2.getDownloadURL();
      DocumentReference ref =
          await databaseReference.collection("Complaints").add({
        'department': _department,
        'Author': uid,
        'Complaint': _detailsController.text,
        'image': url,
      });
      print(ref.documentID);
    } catch (e) {
      print(e);
      print('please try again');
    }
  }
}
