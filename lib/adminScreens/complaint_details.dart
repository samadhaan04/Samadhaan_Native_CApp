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
  var subject, dateReal;
  bool expandedDesc = true;
  bool expandedImg = true;
  bool expandedLog = true;
  bool expandedReq = true;
  bool request = true;
  bool pressed = true;
  var workCity, workState;
  bool feedback = true;
  var department;
  var requestText = "Enter Request";
  TextEditingController reqORfeed = TextEditingController();
  var ref;
  var previouspath;
  var loading = false;
  int selectitem = 1;
  var user;
  String requestFromDepartment;
  List logs;
  var status;
  var isNew;
  Firestore _firestore;
  bool isOnce = true;
  var depts;
  var previousDepartment;
  var transferToDepartment;
  var name, phone, address;

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
      workCity = pref.getString('workCity');
      workState = pref.getString('workState');
      print('$workCity $workState');
      _firestore
          .document('States/$workState/$workCity/data/DepartmentNames/names')
          .get()
          .then((value) {
        depts = value.data['Names'].toList();
        print(depts);
      });
    });
  }

  @override
  void didChangeDependencies() async {
    dynamic arguments = ModalRoute.of(context).settings.arguments;
    ref = arguments['complaintId'];
    previouspath = arguments['path'];
    _firestore.document('DepartmentNames/StateCode').get().then((value) {
      print('check State  ${value.data}');
      value.data.forEach((key, value) {
        print('$key == $value');
      });
    });
    super.didChangeDependencies();
  }

  void findData(var data) {
    _firestore.document('Users/${data['author']}').get().then((value) {
      name = value['name'];
      phone = value['phoneNumber'];
      address = '${value['houseNumber']}, ${value['street']}';
    });
  }

  void newToOld() {
    if (isOnce && user != null && user != "Admin") {
      _firestore.document(previouspath).updateData({
        'status': 0,
      });
      _firestore.document(ref).updateData({
        'status': 0,
      });
      isOnce = false;
    }
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_left,
                    size: 30,
                    color: Color(0xff0371dd),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Text(
                  'Back',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff0371dd),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 6,
            ),
            SingleChildScrollView(
              child: StreamBuilder<DocumentSnapshot>(
                  stream: _firestore.document(ref).snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      var data = snapshot.data.data;
                      findData(data);
                      subject = data['subject'];
                      dateReal = data['date'];
                      var date = DateFormat.yMMMEd()
                          .format(DateTime.parse(data['date']));
                      requestFromDepartment = data['transferRequest'] == ''
                          ? null
                          : data['transferRequest'];
                      previousDepartment = data['department'];
                      transferToDepartment = data['transferToDepartment'] == ''
                          ? null
                          : data['transferToDepartment'];
                      logs = data['logs'];
                      status = data['status'];
                      print('user $user');
                      print('requestFromDepartment $requestFromDepartment');
                      if (status == 3) {
                        newToOld();
                      }
                      isNew = data['new'];
                      // print('status $status');
                      return Column(
                        children: <Widget>[
                          ReusableCardComplaint(
                            colour: Theme.of(context).disabledColor,
                            cardChild: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                                      begin:
                                                          Alignment.centerLeft,
                                                      end:
                                                          Alignment.centerRight,
                                                    )
                                                  : status == 3
                                                      ? LinearGradient(
                                                          colors: [
                                                            Color(0xff3d84fa),
                                                            Color(0xff34afff),
                                                          ],
                                                          begin: Alignment
                                                              .centerLeft,
                                                          end: Alignment
                                                              .centerRight,
                                                        )
                                                      : LinearGradient(
                                                          colors: [
                                                            Color.fromRGBO(236,
                                                                93, 59, 0.8),
                                                            Color.fromRGBO(238,
                                                                120, 61, 0.8),
                                                          ],
                                                          begin: Alignment
                                                              .centerLeft,
                                                          end: Alignment
                                                              .centerRight,
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
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .color,
                                    fontSize: 16,
                                    fontFamily: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .fontFamily,
                                  ),
                                ),
                                GestureDetector(
                                  child: Container(
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
                                  onTap: () {
                                    return showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          backgroundColor: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          title: Text(
                                            'User Information!!',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1
                                                    .color),
                                          ),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.face,
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1
                                                        .color,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    '$name',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1
                                                            .color),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.call,
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1
                                                        .color,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    '${phone}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1
                                                            .color),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.home,
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1
                                                        .color,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    '$address',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1
                                                            .color),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            FlatButton(
                                              onPressed: () {
                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .pop();
                                              },
                                              child: Text(
                                                'OKAY',
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              ),
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 3),
                            child: Column(
                              children: <Widget>[
                                descExpansion(data['complaintText']),
                                data['imageURL'] == null
                                    ? Container()
                                    : imgExpansion(data['imageURL']),
                                logs.length != 0 ? logExpansion() : Container(),
                                user == 'Admin'
                                    ? transferToDepartment != null
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
          ],
        ),
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
                    0,
                    // MediaQuery.of(context).size.width * 0.03,
                    25,
                  ),
                  child: Container(
                    height:
                        logs.length * 90.0 < 150.0 ? logs.length * 90.0 : 150,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: logs.length,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: EdgeInsets.fromLTRB(0, 6, 0, 0),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    constraints: BoxConstraints.tightFor(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.68),
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
                                  ),
                                ],
                              ),
                            ));
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
                  fontSize: 16,
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
          // mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Actions',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).textTheme.bodyText1.color,
                  fontFamily: Theme.of(context).textTheme.bodyText1.fontFamily,
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
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1.color,
                      ),
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
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.width * 0.01),
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        width: 2,
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
                              if (reqORfeed.text == '') {
                                showSnackbar("Please Fill Feedback");
                              } else {
                                sendFeedbackFromDepartment();
                              }
                            },
                            child: Text(
                              'Send Feedback',
                              style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.bodyText1.color,
                              ),
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
                                child: Text(
                                  department == null
                                      ? "Select Department"
                                      : department,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .color,
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
                                child: Text(
                                  "Submit  Request",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .color,
                                  ),
                                  softWrap: true,
                                ),
                                onPressed: () async {
                                  if ((department == null ||
                                      department == "None")) {
                                    showSnackbar("Please Select Department");
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
            ? Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).textTheme.bodyText1.color,
                  ),
                  borderRadius: BorderRadius.circular(
                    40,
                  ),
                ),
                width: MediaQuery.of(context).size.width * 0.75,
                child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "Mark Complete",
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).textTheme.bodyText1.color,
                    ),
                  ),
                  onPressed: () {
                    markComplete();
                  },
                ))
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
    var solved;
    logs.add('$previousDepartment : Completed the Complaint');
    _firestore.document(ref).updateData({
      'status': 1,
      'logs': logs,
    }).then((value) {
      _firestore.document(previouspath).updateData({
        'status': 1,
      });
      _firestore
          .document('States/$workState/$workCity/data')
          .get()
          .then((value) {
        solved = value.data['solved'];
      });
      _firestore
          .document('States/$workState/$workCity/data')
          .updateData({'solved': solved + 1});
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
          // print(pending);
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
    var pending;
    var referenceParentPath =
        _firestore.document(previouspath).parent().parent().path;
    logs.add('Transfer Request Disapproved');
    _firestore.document(ref).updateData({
      'status': 0,
      'transferRequest': null,
      'transferToDepartment': null,
      'logs': logs,
    }).then((value) {
      _firestore.document(previouspath).updateData({
        'status': 0,
      });
    }).then((value) {
      _firestore.document(referenceParentPath).get().then((value) {
        pending = value.data['pending'];
        // print(pending);
      }).whenComplete(() {
        if (pending >= 1) {
          _firestore.document(referenceParentPath).updateData({
            "pending": pending - 1,
          }).then((value) {
            Navigator.of(context).pop();
          });
        }
      });
    });
  }

  void confirmAction() {
    transferComplaintToanotherDepartmentInReference();
    logs.add('Transfer Request Approved');
    var p, pending;
    print('ppath $previouspath');
    _firestore.document(previouspath).delete();
    var referenceParentPath =
        _firestore.document(previouspath).parent().parent().path;
    // print('path $referenceParentPath');
    _firestore.document(referenceParentPath).get().then((value) {
      p = value.data['p'];
      pending = value.data['pending'];
    }).whenComplete(() {
      if (p == 1) {
        _firestore.document(referenceParentPath).delete();
      } else
        _firestore
            .document(referenceParentPath)
            .updateData({'p': p - 1, 'pending': pending - 1});
    }).whenComplete(() {
      _firestore.document(ref).updateData({
        'status': 3,
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

  void transferComplaintToanotherDepartmentInReference() async {
    int length;
    var justSet = false;
    print(transferToDepartment);
    try {
      await _firestore
          .collection("States/$workState/$workCity")
          .document(transferToDepartment)
          .get()
          .then((value) {
        print('value.data ${value.data}');
        length = value.data['p'];
      });
    } catch (e) {
      print('formation');
      _firestore
          .collection("States/$workState/$workCity")
          .document(transferToDepartment)
          .setData({"p": 1, "pending": 0});
      justSet = true;
    }

    if (!justSet) {
      _firestore
          .collection("States/$workState/$workCity")
          .document(transferToDepartment)
          .updateData({"p": length + 1});
    }

    _firestore
        .document('States/$workState/$workCity/$transferToDepartment')
        .collection('Complaints')
        .add({
      'ref': ref,
      'subject': subject,
      'status': 3,
      'date': dateReal,
    }).then((value) {
      print("Success");
      return true;
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
                        // print('department $department');
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
                      fontSize: 16,
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
                  fontSize: 16,
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
          color: Theme.of(context).textTheme.bodyText1.color,
        ),
        borderRadius: BorderRadius.circular(40),
      ),
      child: TextField(
        controller: reqORfeed,
        decoration: InputDecoration(
          hintText: text,
          hintStyle: TextStyle(
            color: Theme.of(context).textTheme.bodyText1.color,
          ),
        ),
        maxLines: null,
        style: TextStyle(
          fontSize: 15,
          color: Theme.of(context).textTheme.bodyText1.color,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buttonFlat(String childtext, Function pressed) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).textTheme.bodyText1.color,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: FlatButton(
        padding: EdgeInsets.all(14),
        child: Text(
          childtext,
          style: TextStyle(
            fontSize: 15,
            color: Theme.of(context).textTheme.bodyText1.color,
            fontFamily: Theme.of(context).textTheme.bodyText1.fontFamily,
          ),
        ),
        onPressed: pressed,
      ),
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
