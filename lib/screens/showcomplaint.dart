import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ShowComplaint extends StatefulWidget {
  static const routeName = '/show-complaint';
  final databaseReference = Firestore.instance;
  @override
  _ShowComplaintState createState() => _ShowComplaintState();
}

class _ShowComplaintState extends State<ShowComplaint>
    with SingleTickerProviderStateMixin {
  final databaseReference = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  bool isupdate = false;
  String complaintId;
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
  var rating = 3.0;
  @override
  Widget build(BuildContext context) {
    complaintId = ModalRoute.of(context).settings.arguments;

    return StreamBuilder(
        stream: Firestore.instance
            .collection('Complaints')
            .document(complaintId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading");
          }
          var userDocument = snapshot.data;
          print(userDocument["city"]);
          return new Scaffold(
            body: Padding(
              padding: EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.amber,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(userDocument["complaintText"]),
                          Container(
                            alignment: Alignment(1, 1),
                            child: RaisedButton(
                              textColor: Colors.white,
                              child: Text(
                                'Attached Image',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              color: Colors.black,
                              elevation: 10.0,
                              onPressed: () {
                                return _showBottomSheet(
                                    context, userDocument["imageURL"]);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.amber,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(userDocument["deptfeedback"] != null
                              ? userDocument["deptfeedback"]
                              : "None"),
                          Container(
                            alignment: Alignment(1, 1),
                            child: RaisedButton(
                              textColor: Colors.white,
                              child: Text(
                                'Attached Image',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              color: Colors.black,
                              elevation: 10.0,
                              onPressed: () {
                                setState(() {
                                  return _showBottomSheet(
                                      context,
                                      userDocument["deptfeedbackimg"] != null
                                          ? userDocument["deptfeedbackimg"]
                                          : "");
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        RaisedButton(
                          textColor: Colors.white,
                          child: Text(
                            'FEEDBACK',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          color: Colors.pink,
                          elevation: 10.0,
                          onPressed: () {
                            return _showBottomSheet1(context);
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

//  final Widget image ;
  void _showBottomSheet(BuildContext cotx, String imageUrl) {
    int x = 1;
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: cotx,
        builder: (bctx) {
          return Container(
              child: imageUrl == ""
                  ? Text("No Attached Image")
                  : Image.network(
                      imageUrl,
                      fit: BoxFit.contain,
                      height: 250,
                    ));
        });
  }

  void _showBottomSheet1(BuildContext cotx) {
    int x = 1;
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        context: cotx,
        builder: (bctx) {
          return Container(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  height: 20.0,
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
                  height: 20.0,
                ),
                Center(
                  child: SmoothStarRating(
                      allowHalfRating: false,
                      onRated: (v) {
                        setState(() {
                          rating = v;
                        });
                      },
                      starCount: 5,
                      rating: rating,
                      size: 50.0,
                      isReadOnly: false,
//                      filledIconData: Icons.blur_off,
                      halfFilledIconData: Icons.blur_on,
                      color: Colors.blue,
                      borderColor: Colors.blueAccent,
                      spacing: 3.0),
                ),
                SizedBox(
                  height: 100.0,
                ),
                RaisedButton(
                  textColor: Colors.white,
                  child: Text(
                    'FEEDBACK',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  color: Colors.pink,
                  elevation: 10.0,
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
                      } else {
                        final result = await sendData();
                        if (result == true) {
                          Navigator.of(context).pop();
                        }
                      }
                      setState(() {
                        loading = false;
                      });
                    }
                  },
                ),
                SizedBox(
                  height: 100.0,
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

  Future<bool> sendData() async {
    try {
      await databaseReference
          .collection("Complaints")
          .document(complaintId)
          .updateData({
        'userfeedback': _detailsController.text,
        'star': rating,
      }).then((value) {
        print("Success");
        return true;
      });

      return true;
    } catch (e) {
      print(e);
      print('please try again');
      return false;
    }
  }
}
