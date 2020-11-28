import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridabad/data/constants.dart';
import 'package:faridabad/widgets/modalSheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FileComplaint extends StatefulWidget {
  static const routeName = 'file-complaint';

  @override
  _FileComplaintState createState() => _FileComplaintState();
}

class _FileComplaintState extends State<FileComplaint>
    with SingleTickerProviderStateMixin {
  final databaseReference = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  List<dynamic> listOfDepartments;
  bool isupdate = false;
  double width, height;
  String exactDateTime;
  bool loading = false;
  SharedPreferences pref;

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
  TextEditingController _subjectController = new TextEditingController();
  String _department;
  List _images = [];
  File _image;

  void showModalSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white.withOpacity(0.8),
      context: context,
      builder: (_) {
        return ModalSheet();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    fetchCityAndFindDepartmentList(); 
    

  }

  @override
  void didChangeDependencies() {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    super.didChangeDependencies();
  }

  var city, state;
  void fetchCityAndFindDepartmentList() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      city = pref.getString('city');
      state = pref.getString('state');
    });
    databaseReference.document('States/$state/$city/data/DepartmentNames/names').get().then((value) {
      listOfDepartments = value.data['Names'].toList();
    }).whenComplete(() {
      setState(() {
      });
    });
    setState(() {
     
    });
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Opacity(
            opacity: loading ? 0.5 : 1,
            child: Container(
              color: Colors.white,
              child: ListView(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 25.0),
                                child: Text(
                                  'File Complaint',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35,
                                    color: Color(0xff817f7f),
                                  ),
                                ),
                              ),
                              // Text(
                              //   'Complaint',
                              //   textAlign: TextAlign.center,
                              //   style: TextStyle(
                              //       fontWeight: FontWeight.bold,
                              //       fontSize: 30,
                              //       color: Colors.teal[200]),
                              // ),
                            ],
                          ),
                        ),
                        // TO BE DONE: Render a custom image from backend
                        SizedBox(
                          height: 12,
                        ),
                        // Text(
                        //   city ?? "empty",
                        //   textAlign: TextAlign.center,
                        //   style: TextStyle(
                        //     fontWeight: FontWeight.bold,
                        //     fontSize: 25,
                        //     letterSpacing: 1,
                        //     color: Colors.blue[300],
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 30,
                        // ),
                        Container(
                          margin: EdgeInsets.all(10),
                          width: double.infinity,
                          height: height / 1.6,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              style: BorderStyle.solid,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    width: double.infinity,
                                    child: GestureDetector(
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            border: BorderDirectional(
                                                bottom: BorderSide(
                                                    color: Colors.black54))),
                                        child: Row(
                                          children: [
                                            Text(
                                              _department == null
                                                  ? "Select Department"
                                                  : _department,
                                                  overflow: TextOverflow.fade,
                                              style: TextStyle(
                                                fontSize: 21,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_drop_down,
                                              color: listOfDepartments == null
                                                  ? Colors.grey
                                                  : Colors.black,
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () => listOfDepartments == null
                                          ? null
                                          : showModal(context),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  TextFormField(
                                    controller: _subjectController,
                                    keyboardType: TextInputType.text,
                                    autocorrect: false,
                                    maxLines: null,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value == '') {
                                        return 'Please enter Subject';
                                      } else if (value.length >= 150) {
                                        return "Subject should Be less than 150 Words";
                                      }
                                      else{
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      counterText: '',
                                      contentPadding: EdgeInsets.all(5),
                                      hintText: "Subject",
                                    ),
                                    style: TextStyle(
                                      fontSize: 21,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      keyboardType: TextInputType.text,
                                      autocorrect: false,
                                      controller: _detailsController,
                                      maxLines: null,
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value == '') {
                                          return 'Please enter details about your issue';
                                        }
                                        else if(value.length >=500)
                                        {
                                          return 'Complaint should Be less than 500 Words';
                                        }
                                        else
                                        {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        counterText: '',
                                        contentPadding: EdgeInsets.all(5),
                                        hintText: "Complaint",
                                        border: InputBorder.none,
                                      ),
                                      style: TextStyle(
                                        fontSize: 21,
                                        color: Colors.black,
                                      ),
                                      minLines: 1,
                                      // maxLines: 100,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      (_images.length == 0)
                                          ? Expanded(
                                              child: Container(),
                                            )
                                          : Expanded(
                                              child: SizedBox(
                                                height: 60,
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  key: GlobalKey(),
                                                  itemCount: _images.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Row(
                                                      children: [
                                                        preview(_images[index]),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                      IconButton(
                                        icon: Icon(Icons.photo_camera,
                                            size: 30,
                                            color: _images.length >= 4
                                                ? Colors.grey
                                                : Colors.black),
                                        onPressed: () {
                                          if (_images.length >= 4)
                                            return null;
                                          else
                                            return showDialog(
                                              context: context,
                                              child: AlertDialog(
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                title: Text(
                                                  "Choose an Option",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                actions: <Widget>[
                                                  MaterialButton(
                                                    child: Text(
                                                      "Gallery",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    onPressed: () async {
                                                      final picker =
                                                          ImagePicker();
                                                      final pickedImage =
                                                          await picker.getImage(
                                                        source:
                                                            ImageSource.gallery,
                                                        imageQuality: 50,
                                                      );
                                                      setState(() {
                                                        _image = File(
                                                            pickedImage.path);
                                                        _images.add(_image);
                                                        Navigator.of(context,
                                                                rootNavigator:
                                                                    true)
                                                            .pop();
                                                      });
                                                      //
                                                    },
                                                  ),
                                                  MaterialButton(
                                                    child: Text(
                                                      "Camera",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    onPressed: () async {
                                                      final picker =
                                                          ImagePicker();
                                                      final pickedImage =
                                                          await picker.getImage(
                                                        source:
                                                            ImageSource.camera,
                                                        imageQuality: 50,
                                                      );
                                                      setState(() {
                                                        _image = File(
                                                            pickedImage.path);
                                                        _images.add(_image);
                                                        Navigator.of(context,
                                                                rootNavigator:
                                                                    true)
                                                            .pop();
                                                      });
                                                      // Navigator.of(context).pop();
                                                    },
                                                  )
                                                ],
                                              ),
                                            );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          child: Container(
                            // padding: const EdgeInsets.only(top: 20),
                            height: 70,
                            alignment: Alignment.center,
                            width: width / 2,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 30,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onTap: () async {
                            {
                              var result = _formKey.currentState.validate();
                              if(result)
                              {
                                setState(() {
                                loading = true;
                              });
                              if (_images.length > 4) {
                                setState(() {
                                  loading = false;
                                });
                                _scaffoldKey.currentState.showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                      'Maximum 4 Images Can Be  Uploaded',
                                    ),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              } else if (_department == null ||
                                  _detailsController.text == null ||
                                  _subjectController.text == null) {
                                setState(() {
                                  loading = false;
                                });
                                _scaffoldKey.currentState.showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                      'Please Enter Your Details',
                                    ),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              } else {
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
                                  exactDateTime =  DateTime.now().toIso8601String();
                                  final result = await sendData();
                                  if (result == true) {
                                    print("work done!!");
                                    Navigator.of(context).pop();
                                  }
                                }
                                setState(() {
                                  loading = false;
                                });
                                showModalSheet(context);
                              }
                              }
                              else{
                                _scaffoldKey.currentState.showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                      'Please Enter Your Details Correctly',
                                    ),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Opacity(
            opacity: loading ? 1 : 0,
            child: Center(
              child: CircularProgressIndicator(
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget preview(File image) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: GestureDetector(
            child: Image.file(image),
            onTap: () {
              showDialog(
                context: context,
                child: AlertDialog(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: Image.file(image),
                  actions: [
                    FlatButton(
                      padding: EdgeInsets.all(10),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text("Okay!"),
                    )
                  ],
                ),
              );
            },
          ),
        ),
        Positioned(
          top: -5,
          right: -5,
          child: CircleAvatar(
            radius: 10,
            backgroundColor: Colors.black,
            child: GestureDetector(
              child: Icon(
                Icons.clear,
                color: Colors.white,
                size: 20,
              ),
              onTap: () {
                _images.removeWhere((element) {
                  return element == image;
                });
                setState(() {});
              },
            ),
          ),
        ),
      ],
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

  Future<bool> sendData() async {
    var urls = [];
    try {
      final uid = await _auth.currentUser().then((value) => value.uid);
      DocumentReference ref =
          await databaseReference.collection("Complaints").add({
        'author': uid,
        'complaintText': _detailsController.text,
        'imageURL': _images.length == 0 ? null : urls,
        'state': state,
        'subject': _subjectController.text,
        'status': 3,
        'name': pref.getString('name'),
        'city': city,
        'department': _department,
        'deptFeedback': null,
        'userFeedback': null,
        'deptFeedbackImg': null,
        'adminRemark': null,
        'star': null,
        'new': true,
        'date': exactDateTime,
        'token': pref.getString('token'),
        'transferToDepartment': null,
        'transferRequest': null,
        'logs': [],
      });
      if (_images.length != 0) {
        _images.forEach((element) async {
          final ref2 = FirebaseStorage.instance
              .ref()
              .child('complaintImages')
              .child(uid + DateTime.now().toIso8601String() + '.jpg');
          await ref2.putFile(element).onComplete;
          await ref2.getDownloadURL().then((value) {
            urls.add(value);
          }).then((value) {
            databaseReference.document(ref.path).updateData({'imageURL': urls});
          });
        });
      }

      print("start check");
      await databaseReference
          .collection("Users/$uid/previousComplaints")
          .add({"ref": ref.path,'date':exactDateTime});
      print(ref.path);
      int length;
      int pending;
      int totalForCity;
      var justSet  = false;
      try {
        await databaseReference
            .collection("States/$state/$city")
            .document('data')
            .get()
            .then((value) {
          totalForCity = value.data['total'];
        });
      } catch (e) {
        await databaseReference
            .collection("States/$state/$city")
            .document('data')
            .setData({
          "total": 1,
          "solved": 0,
        });
        totalForCity = 0;
      }
      if (totalForCity != 0) {
        await databaseReference
            .collection("States/$state/$city")
            .document('data')
            .updateData({
          "total": totalForCity + 1,
        });
      }
      try {
        await databaseReference
            .collection("States/$state/$city")
            .document(_department)
            .get()
            .then((value) {
          length = value.data['p'];
          pending = value.data['pending'];
        });
      } catch (e) {
        print('formation');
        await databaseReference
            .collection("States/$state/$city")
            .document(_department)
            .setData({
          "p": 1,
          "pending": 0,
        });
        justSet = true;
      }
      if (!justSet) {
        await databaseReference
            .collection("States/$state/$city")
            .document(_department)
            .updateData({
          "p": length + 1,
          "pending": pending,
        });
      }
      await databaseReference
          .document('States/$state/$city/$_department')
          .collection('Complaints')
          .add({
        'ref': ref.path,
        'subject': _subjectController.text,
        'status': 3,
        'date': exactDateTime,
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

  void showModal(context) {
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
                      listOfDepartments.length,
                      (index) => Center(
                        child: Text(
                          listOfDepartments[index],
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    itemExtent: 50, //height of each item
                    looping: false,
                    onSelectedItemChanged: (int index) {
                      setState(() {
                        _department = listOfDepartments[index];
                        print(_department);
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}
