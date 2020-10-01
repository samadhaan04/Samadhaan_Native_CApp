import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridabad/adminScreens/complaintDescriptionCard.dart';
import 'package:faridabad/adminScreens/listOfDepartments.dart';
import 'package:faridabad/data/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ComplaintDetails extends StatefulWidget {
  static const routeName = '/complaint-details';

  @override
  _ComplaintDetailsState createState() => _ComplaintDetailsState();
}

class _ComplaintDetailsState extends State<ComplaintDetails> {
  bool expandedDesc = true;
  bool expandedImg = true;
  bool expandedLog = true;
  bool expandedReq = true;
  bool request = true;
  bool pressed = true;
  bool feedback = true;
  var department;
  var requestText = "Enter Request";
  TextEditingController reqORfeed = TextEditingController();
  var ref;
  var previouspath;
  int selectitem = 1;
  var user;
  // TextEditingController requestFromDepartment = TextEditingController();
  String requestFromDepartment;
  List logs;
  var status;
  var isNew;
  Firestore _firestore;
  bool isOnce = true;
  var depts;
  var previousDepartment;
  var transferToDepartment;

  @override
  void initState() {
    _firestore = Firestore.instance;
    getCurrentUserAndFetchDetails();
    super.initState();
  }

  void getCurrentUserAndFetchDetails() async {
    var pref = await SharedPreferences.getInstance();
    setState(() {
      user = pref.getString('currentUser');
      _firestore.document('DepartmentNames/Names').get().then((value) {
        depts = value.data['names'].toList();
      });
      print(' requestfromDepartment $requestFromDepartment');
    });
  }

  @override
  void didChangeDependencies() async {
    dynamic arguments = ModalRoute.of(context).settings.arguments;
    ref = arguments['complaintId'];
    previouspath = arguments['path'];
    if (isOnce && user != null && user != "Admin") {
      _firestore.document(previouspath).updateData({
        'status': 0,
      });
      _firestore.document(ref).updateData({
        'status' : 0,
      });
      isOnce = false;
    }
    super.didChangeDependencies();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: Colors.grey),
        automaticallyImplyLeading: false,
        titleSpacing: -12.0,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            size: 38,
            color: Color(0xff0371dd),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Back',
          style: TextStyle(
            color: Color(0xff0371dd),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<DocumentSnapshot>(
            stream: _firestore.document(ref).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                // print(snapshot.data.data);
                var data = snapshot.data.data;
                var date =
                    DateFormat.yMMMEd().format(DateTime.parse(data['date']));
                requestFromDepartment = data['transferRequest'] == ''
                    ? null
                    : data['transferRequest'];
                previousDepartment = data['department'];
                transferToDepartment = data['transferToDepartment'] == ''
                    ? null
                    : data['transferToDepartment'];
                logs = data['logs'];
                status = data['status'];
                isNew = data['new'];
                print('status $status');
                return Column(
                  children: <Widget>[
                    ReusableCardComplaint(
                      colour: Theme.of(context).disabledColor,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                // '15 Jul 2020',
                                date.toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontFamily: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .fontFamily,
                                ),
                              ),
                              CircleAvatar(
                                radius: 15,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: status == 0
                                        ? LinearGradient(
                                            colors: [
                                              Color(0xfff4b601),
                                              Color(0xffffee77),
                                            ],
                                          )
                                        : status == 1
                                            ? LinearGradient(
                                                colors: [
                                                  Color(0xff51b328),
                                                  Color(0xff85eb29),
                                                ],
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                              )
                                            : status == 3
                                                ? LinearGradient(
                                                    colors: [
                                                      Color(0xff3d84fa),
                                                      Color(0xff34afff),
                                                    ],
                                                    begin: Alignment.centerLeft,
                                                    end: Alignment.centerRight,
                                                  )
                                                : LinearGradient(
                                                    colors: [
                                                      Color.fromRGBO(
                                                          236, 93, 59, 0.8),
                                                      Color.fromRGBO(
                                                          238, 120, 61, 0.8),
                                                    ],
                                                    begin: Alignment.centerLeft,
                                                    end: Alignment.centerRight,
                                                  ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            // 'Sir hmare ghar ke bahr sadak tut gayi hai',
                            data['subject'],
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1.color,
                              fontSize: 16,
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .fontFamily,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              bottom: 7,
                            ),
                            alignment: Alignment.centerRight,
                            child: Text(
                              '-${data['name']}',
                              // data['name'],
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontFamily: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .fontFamily,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 3),
                      child: Column(
                        children: <Widget>[
                          descExpansion(data['complaintText']),
                          data['imageURL'] == null
                              ? Container()
                              : imgExpansion(data['imageURL']),
                          logs.length != 0 ? logExpansion() : Container(),
                          user == 'Admin'
                              ? requestFromDepartment != null
                                  ? reqExpansionAdmin()
                                  : Container()
                              : status != 2
                                  ? status != 1
                                      ? actionExpansionDepartment()
                                      : Container()
                                  : Container(),
                        ],
                      ),
                    )
                  ],
                );
              }
            }),
      ),
    );
  }

  Widget descExpansion(String complaint) {
    return expandedDesc
        ? Wrap(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Description',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1.color,
                      fontSize: 16,
                      fontFamily:
                          Theme.of(context).textTheme.bodyText1.fontFamily,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.expand_less,
                      size: 40,
                      color: Theme.of(context).textTheme.bodyText1.color,
                    ),
                    onPressed: () {
                      setState(() {
                        expandedDesc = !expandedDesc;
                      });
                    },
                  )
                ],
              ),
              SizedBox(
                height: 4,
              ),
              SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15)),
                  padding: EdgeInsets.fromLTRB(25, 20, 25, 40),
                  child: Text(
                    complaint,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily:
                          Theme.of(context).textTheme.bodyText1.fontFamily,
                      color: Theme.of(context).textTheme.bodyText1.color,
                    ),
                  ),
                ),
              )
            ],
          )
        : Row(
            children: <Widget>[
              Text(
                'Description',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: Theme.of(context).textTheme.bodyText1.fontFamily,
                  color: Theme.of(context).textTheme.bodyText1.color,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.expand_more,
                  size: 40,
                  color: Theme.of(context).textTheme.bodyText1.color,
                ),
                onPressed: () {
                  setState(() {
                    expandedDesc = !expandedDesc;
                  });
                },
              )
            ],
          );
  }

  Widget imgExpansion(var images) {
    return expandedImg
        ? Wrap(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Images',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1.color,
                      fontSize: 16,
                      fontFamily:
                          Theme.of(context).textTheme.bodyText1.fontFamily,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.expand_less,
                      size: 40,
                      color: Theme.of(context).textTheme.bodyText1.color,
                    ),
                    onPressed: () {
                      setState(() {
                        expandedImg = !expandedImg;
                      });
                    },
                  )
                ],
              ),
              SizedBox(
                height: 7,
              ),
              SingleChildScrollView(
                child: Container(
                  height: 200,
                  child: ListView.builder(
                    key: GlobalKey(),
                    itemCount: images.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return imageBox(images[index]);
                    },
                  ),
                ),
              )
            ],
          )
        : Row(
            children: <Widget>[
              Text(
                'Images',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: Theme.of(context).textTheme.bodyText1.fontFamily,
                  color: Theme.of(context).textTheme.bodyText1.color,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.expand_more,
                  size: 40,
                  color: Theme.of(context).textTheme.bodyText1.color,
                ),
                onPressed: () {
                  setState(() {
                    expandedImg = !expandedImg;
                  });
                },
              )
            ],
          );
  }

  Widget imageBox(var imageUrl) {
    // print(imageUrl);
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            child: AlertDialog(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Hero(
                tag: 'image',
                child: Image.network(imageUrl),
              ),
            ),
          );
        },
        child: Hero(
          tag: 'image',
          child: Image.network(imageUrl,
              loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null)
              return child;
            else
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes
                      : null,
                ),
              );
          }),
        ),
      ),
    );
  }

  Widget logExpansion() {
    return expandedLog
        ? Wrap(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Logs',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1.color,
                      fontSize: 16,
                      fontFamily:
                          Theme.of(context).textTheme.bodyText1.fontFamily,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.expand_less,
                      size: 40,
                      color: Theme.of(context).textTheme.bodyText1.color,
                    ),
                    onPressed: () {
                      setState(() {
                        expandedLog = !expandedLog;
                      });
                    },
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15)),
                  padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.05,
                    25,
                    MediaQuery.of(context).size.width * 0.03,
                    25,
                  ),
                  child: Container(
                    width: double.infinity,
                    height:
                        logs.length * 90.0 < 200.0 ? logs.length * 90.0 : 200,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: logs.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.fromLTRB(0, 6, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .color,
                                ),
                                height: 20,
                                width: 5,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                width: 300,
                                child: Text(
                                  logs[index],
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .color,
                                    fontFamily: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .fontFamily,
                                    fontSize: 14,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ))
            ],
          )
        : Row(
            children: <Widget>[
              Text(
                'Logs',
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).textTheme.bodyText1.color,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.expand_more,
                  size: 40,
                  color: Theme.of(context).textTheme.bodyText1.color,
                ),
                onPressed: () {
                  setState(() {
                    expandedLog = !expandedLog;
                  });
                },
              )
            ],
          );
  }

  //************************************************REQUEST*************************************  ********/
  Widget actionExpansionDepartment() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Actions',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            !request || !feedback
                ? FlatButton(
                    onPressed: () {
                      setState(() {
                        request = true;
                        feedback = true;
                        pressed = true;
                        department = null;
                        reqORfeed.text = "";
                      });
                    },
                    child: Text(
                      "Go back <--",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : Container(),
          ],
        ),
        SizedBox(
          height: 14,
        ),
        pressed
            ? SingleChildScrollView(
                child: Container(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      buttonFlat(
                        "Feedback",
                        () {
                          setState(() {
                            pressed = false;
                            feedback = false;
                            request = true;
                          });
                        },
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      buttonFlat(
                        "Request Transfer",
                        () {
                          setState(() {
                            pressed = false;
                            feedback = true;
                            request = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              )
            : request
                ? Column(
                    children: <Widget>[
                      textField(
                        'Enter Feedback',
                      ),
                      Center(
                        child: FlatButton(
                            onPressed: () {
                              sendFeedbackFromDepartment();
                            },
                            child: Text(
                              'Send Feedback',
                              style: TextStyle(color: Colors.white),
                            )),
                      )
                    ],
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        textField(requestText),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              FlatButton(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 7),
                                shape: Border.all(color: Colors.white),
                                child: Text(
                                  department == null
                                      ? "Select Department"
                                      : department,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                  softWrap: true,
                                ),
                                onPressed: () {
                                  showModal(context);
                                },
                              ),
                              SizedBox(
                                width: 14,
                              ),
                              FlatButton(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 7),
                                shape: Border.all(color: Colors.white),
                                child: Text(
                                  "Submit Transfer Request",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                  softWrap: true,
                                ),
                                onPressed: () async {
                                  if ((department == null ||
                                          department == "None") &&
                                      reqORfeed.text.isEmpty) {
                                    showSnackbar("Please Fill Information");
                                  } else if (department == null) {
                                    showSnackbar("Please Select Department");
                                  } else if (reqORfeed.text.isEmpty) {
                                    showSnackbar('Please Enter Request');
                                  } else {
                                    submitTransferRequest();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
        SizedBox(
          height: 15,
        ),
        status != 1 || status != 2
            ? FlatButton(
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                shape: Border.all(color: Colors.white),
                child: Text(
                  "Mark Complete",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  markComplete();
                },
              )
            : Container(),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  void sendFeedbackFromDepartment() {
    logs.add('$previousDepartment : ${reqORfeed.text}');
    _firestore.document(ref).updateData({
      "deptFeedback": reqORfeed.text,
      'logs': logs,
    }).then((value) {
      setState(() {
        reqORfeed.text = '';
      });
    });
    showSnackbar('Feedback Sent Successfully!!');
  }

  void markComplete() {
    logs.add('$previousDepartment : Completed the Complaint');
    _firestore.document(ref).updateData({
      'status': 1,
      'logs': logs,
    }).then((value) {
      _firestore.document(previouspath).updateData({
        'status': 1,
      });
    }).then((value) {
      Navigator.of(context).pop();
    });
  }

  void submitTransferRequest() {
    var pending;
    logs.add(
        '$previousDepartment Requested Transfer of Complaint to $department');
    _firestore.document(ref).updateData({
      'transferRequest': reqORfeed.text,
      'transferToDepartment': department,
      'logs': logs,
      'status': 2,
    }).then((value) {
      reqORfeed.text = '';
      var referenceParentPath =
          _firestore.document(previouspath).parent().parent().path;
      _firestore.document(previouspath).updateData({
        'status': 2,
      }).then((value) {
        _firestore.document(referenceParentPath).get().then((value) {
          pending = value.data['pending'];
          print(pending);
        }).whenComplete(() {
          _firestore.document(referenceParentPath).updateData({
            "pending": pending + 1,
          });
        });
      }).then((value) {
        Navigator.of(context).pop();
      });
    });
  }

  void dismissRequest() {
    logs.add('Transfer Request Disapproved');
    _firestore.document(ref).updateData({
      'status': 0,
      'transferRequest': null,
      'transferToDepartment': null,
      'logs': logs,
    }).then((value) {
      _firestore.document(previouspath).updateData({
        'status': 0,
      }).then((value) {
        Navigator.of(context).pop();
      });
    });
  }

  void confirmAction() {
    transferComplaintToanotherDepartmentInReference();
    logs.add('Transfer Request Approved');
    var p, pending;
    _firestore.document(previouspath).delete();
    var referenceParentPath =
        _firestore.document(previouspath).parent().parent().path;
    print('path $referenceParentPath');
    _firestore.document(referenceParentPath).get().then((value) {
      p = value.data['p'];
      pending = value.data['pending'];
    }).whenComplete(() {
      _firestore
          .document(referenceParentPath)
          .updateData({'p': p - 1, 'pending': pending - 1});
    }).whenComplete(() {
      _firestore.document(ref).updateData({
        'status': 0,
        'department': transferToDepartment,
        'transferRequest': null,
        'transferToDepartment': null,
        'logs': logs,
        'deptFeedback': null,
      }).whenComplete(() {
        Navigator.of(context).pop();
      });
    });
  }

  void transferComplaintToanotherDepartmentInReference() {
    var subject, date;
    _firestore.document(ref).get().then((value) {
      subject = value.data['subject'];
      date = value.data['date'];
    }).whenComplete(() async {
      int length;

      await _firestore
          .collection("States/Haryana/Palwal")
          .document(transferToDepartment)
          .get()
          .then((value) {
        if (value.data != null) {
          length = value.data['p'];
        }
      }).catchError((e) {
        _firestore
            .collection("States/Haryana/Palwal")
            .document(transferToDepartment)
            .setData({"p": 1, "pending": 0});
        length = 0;
      });

      if (length != 0) {
        _firestore
            .collection("States/Haryana/Palwal")
            .document(transferToDepartment)
            .updateData({"p": length + 1});
      }

      _firestore
          .document('States/Haryana/Palwal/$transferToDepartment')
          .collection('Complaints')
          .add({
        'ref': ref,
        'subject': subject,
        'status': 0,
        'date': date,
      }).then((value) {
        print("Success");
        return true;
      });
    });
  }

  void showSnackbar(String message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: Colors.blue,
        content: Text(
          message,
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void showModal(context) {
    var items = depts.where((element) => element != user).toList();
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
                      items.length,
                      (index) => Center(
                        child: Text(
                          items[index],
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    itemExtent: 50, //height of each item
                    looping: false,
                    onSelectedItemChanged: (int index) {
                      setState(() {
                        selectitem = index;
                        department = items[selectitem];
                        print('department $department');
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget reqExpansionAdmin() {
    return expandedReq
        ? Wrap(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Request',
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).textTheme.bodyText1.color,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.expand_less,
                      size: 40,
                      color: Theme.of(context).textTheme.bodyText1.color,
                    ),
                    onPressed: () {
                      setState(() {
                        expandedReq = !expandedReq;
                      });
                    },
                  )
                ],
              ),
              SizedBox(
                height: 7,
              ),
              Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(15)),
                    padding: EdgeInsets.symmetric(vertical: 25, horizontal: 30),
                    child: TextFormField(
                      readOnly: true,
                      maxLines: 4,
                      initialValue: requestFromDepartment,
                      // controller: request,
                      minLines: 1,
                      decoration: InputDecoration(border: InputBorder.none),
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1.color,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // ShowModalDrop(), //FUNCTION***************************//
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      UtilButton(
                        childtext: 'Dismiss Request',
                        onpress: () {
                          dismissRequest();
                        },
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      UtilButton(
                        childtext: 'Confirm Action',
                        onpress: () {
                          confirmAction();
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              )
            ],
          )
        : Row(
            children: <Widget>[
              Text(
                'Request',
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).textTheme.bodyText1.color,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.expand_more,
                  size: 40,
                  color: Theme.of(context).textTheme.bodyText1.color,
                ),
                onPressed: () {
                  setState(() {
                    expandedReq = !expandedReq;
                  });
                },
              )
            ],
          );
  }

  Widget textField(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
        ),
      ),
      child: TextField(
        controller: reqORfeed,
        decoration: InputDecoration(
          hintText: text,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.5),
          ),
        ),
        maxLines: null,
        style: TextStyle(
          fontSize: 15,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buttonFlat(String childtext, Function pressed) {
    return FlatButton(
      padding: EdgeInsets.all(20),
      shape: Border.all(color: Colors.white),
      child: Text(
        childtext,
        style: TextStyle(
          fontSize: 15,
          color: Colors.white,
        ),
      ),
      onPressed: pressed,
    );
  }
}

// *******************************UTIL BUTTON***************************************//
class UtilButton extends StatelessWidget {
  final String childtext;
  final Function onpress;

  UtilButton({
    this.childtext,
    this.onpress,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 4),
      color: Colors.white.withOpacity(0.08),
      child: Text(
        childtext,
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).textTheme.bodyText1.color,
        ),
      ),
      onPressed: onpress,
    );
  }
}
