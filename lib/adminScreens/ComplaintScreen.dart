import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridabad/adminScreens/adminProfile.dart';
import 'package:faridabad/adminScreens/complaint_details.dart';
import 'package:faridabad/adminScreens/departmentComplaintDescription.dart';
import 'package:faridabad/main.dart';
import 'package:faridabad/providers/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/CircularAvatar.dart';
import '../data/complaint.dart';
import '../widgets/switch.dart';

class ComplaintScreen extends StatefulWidget {
  static const routeName = '/complaintScreen';
  final String department;
  ComplaintScreen([this.department]);
  @override
  _ComplaintScreenState createState() => _ComplaintScreenState();
}

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;
String email;
int sort = 0;

class _ComplaintScreenState extends State<ComplaintScreen> {
  var transferValue = false;
  var newValue = false;
  var ongoingValue = false;
  var doneValue = false;

  String messageText;
  // var uid;
  var ref;
  var user, workCity, workState;
  bool isOnce = true;
  Map topic;
  final fbm = FirebaseMessaging();
  List<String> listOfReferences = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    if (isOnce) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      if (widget.department != null) {
        ref = widget.department;
      } else {
        ref = ModalRoute.of(context).settings.arguments;
      }
      setState(() {
        user = pref.getString('currentUser');
        workCity = pref.getString('workCity');
        workState = pref.getString('workState');
      });
      if (user != 'Admin') {
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
            return;
          },
          onResume: (message) {
            print('onBackgroundMessage');
            print(message);
            return;
          },
        );
        print('fbm configured');
        _firestore.document('DepartmentNames/topic').get().then((value) {
          topic = value.data['topic'];
          var topicForuser = topic[user];
          var topicName = workState + workCity + topicForuser;
          print('topic for department $topicName');
          fbm.subscribeToTopic(topicName);
          print('subscribed to $topicName');
        });
        setState(() {
          isOnce = false;
        });
      }
    }
    super.didChangeDependencies();
  }

  bool transfer = false;

  changeState() {
    setState(() {});
  }

  //condition function for theme to build switch gradients
  bool darkMode() {
    if (Theme.of(context).textTheme.bodyText1.color == Colors.white)
      return true;
    else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
            icon: Icon(Icons.account_circle),
            onPressed: () => Navigator.of(context)
                .pushReplacementNamed(AdminProfile.routename, arguments: user),
            iconSize: 35,
            color: Colors.grey[600],
          )
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 30, 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 15, left: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: 2,
                        color: Color(0xf3f3f3f3),
                      ),
                    ),
                    child:
                        // Text('hello', style: TextStyle(color: Colors.white),),
                        RollingSwitch(
                      textOff: 'Transfer',
                      textOn: 'Transfer',
                      onChanged: (v) {},
                      onTap: () {
                        transferValue = !transferValue;
                        doneValue = false;
                        ongoingValue = false;
                        setState(() {});
                      },
                      value: transferValue,
                      colorOff: Colors.transparent,
                      colorOn: Color(0xffFE7325),
                      myGradient: darkMode()
                          ? LinearGradient(
                              colors: [
                                Color.fromRGBO(236, 93, 59, 0.8),
                                Color.fromRGBO(238, 120, 61, 0.8),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            )
                          : LinearGradient(
                              colors: [
                                Color(0xffff4A2B),
                                Color(0xffFE7325),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                      pad: 0,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.001,
                  ),
                  //Expanded(
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: 2,
                        color: Color(0xf3f3f3f3),
                      ),
                    ),
                    child: RollingSwitch(
                      value: ongoingValue,
                      textOff: 'Ongoing',
                      textOn: 'Ongoing',
                      onChanged: (v) {},
                      onTap: () {
                        transferValue = false;
                        doneValue = false;
                        ongoingValue = !ongoingValue;
                        setState(() {});
                      },
                      colorOff: Colors.transparent,
                      colorOn: Color(0xfff4b601),
                      myGradient: darkMode()
                          ? LinearGradient(
                              colors: [
                                Color(0xfff4b601),
                                Color(0xffffee77),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            )
                          : LinearGradient(
                              colors: [
                                Color(0xfff4b601),
                                Color(0xffffee77),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                      pad: 0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 2, 30, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 15, left: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: 2,
                        color: Color(0xf3f3f3f3),
                      ),
                    ),
                    child: RollingSwitch(
                      textOff: 'New',
                      textOn: 'New',
                      onChanged: (v) {},
                      onTap: () {
                        transferValue = false;
                        newValue = !newValue;
                        doneValue = false;
                        ongoingValue = false;
                        setState(() {});
                      },
                      value: newValue,
                      colorOff: Colors.transparent,
                      colorOn: Color.fromRGBO(77, 136, 242, 1),
                      myGradient: darkMode()
                          ? LinearGradient(
                              colors: [
                                Color.fromRGBO(80, 141, 243, 1),
                                Color.fromRGBO(88, 170, 247, 1),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            )
                          : LinearGradient(
                              colors: [
                                Color.fromRGBO(77, 137, 241, 0.8),
                                Color.fromRGBO(85, 167, 245, 0.8),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                      pad: 10,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.001,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: 2,
                        color: Color(0xf3f3f3f3),
                      ),
                    ),
                    child: RollingSwitch(
                      textOff: 'Done',
                      textOn: 'Done',
                      onChanged: (v) {},
                      onTap: () {
                        transferValue = false;
                        doneValue = !doneValue;
                        ongoingValue = false;
                        setState(() {});
                      },
                      value: doneValue,
                      colorOff: Colors.transparent,
                      colorOn: Color(0xff85eb29),
                      myGradient: darkMode()
                          ? LinearGradient(
                              colors: [
                                Color(0xff51b328),
                                Color(0xff85eb29),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            )
                          : LinearGradient(
                              colors: [
                                Color.fromRGBO(113, 182, 67, 0.8),
                                Color.fromRGBO(153, 224, 80, 0.8),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                      pad: 10,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: MessagesStream1(transferValue, ongoingValue, doneValue,
                    newValue, listOfReferences, ref)),
          ],
        ),
      ),
    );
  }
}

class MessagesStream1 extends StatefulWidget {
  // final uid;
  final transferValue;
  final ongoingValue;
  final newValue;
  final doneValue;
  final listOfReferences;
  final department;
  MessagesStream1(this.transferValue, this.ongoingValue, this.doneValue,
      this.newValue, this.listOfReferences, this.department);

  @override
  _MessagesStream1State createState() => _MessagesStream1State();
}

class _MessagesStream1State extends State<MessagesStream1> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    // print('uid ${widget.uid}');
    return StreamBuilder(
      stream: _firestore
          .collection('States/Haryana/Palwal/${widget.department}/Complaints')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          List<DocumentSnapshot> list;
          if (widget.ongoingValue == true) {
            list = snapshot.data.documents.where((DocumentSnapshot val) {
              return (val['status'] == 0);
            }).toList();
            // print(list);
          } else if (widget.doneValue == true) {
            list = snapshot.data.documents
                .where((val) => (val['status'] == 1))
                .toList();
            // print(list);
          } else if (widget.transferValue == true) {
            list = snapshot.data.documents
                .where((val) => (val['status'] == 2))
                .toList();
          } else if (widget.newValue == true) {
            list = snapshot.data.documents
                .where((val) => (val['status'] == 3))
                .toList();
          } else {
            list = snapshot.data.documents;
          }
          // print(list);
          return list.isEmpty
              ? Container(
                  child: Center(
                    child: Text(
                      "No Complaints Yet !!!",
                      style: TextStyle(
                        fontSize: 21,
                        color: Theme.of(context).textTheme.bodyText1.color,
                      ),
                    ),
                  ),
                )
              : ListView.builder(
                  key: GlobalKey(),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    print(list[index].reference.path);
                    return MessageBubble(
                      complaint: list[index]['subject'],
                      department: widget.department,
                      status: list[index]['status'],
                      complaintId: list[index]['ref'],
                      date: list[index]['date'],
                      path: list[index].reference.path,
                      color: (index % 2 == 0)
                          ? Theme.of(context).disabledColor
                          //Color.fromARGB(255, 33, 30, 43)
                          : Theme.of(context).scaffoldBackgroundColor,
                      //Color(0xff15131E),
                    );
                  });
        }
      },
    );
  }
}

class MessageBubble extends StatefulWidget {
  MessageBubble(
      {this.status,
      this.complaint,
      this.complaintId,
      this.department,
      this.path,
      this.date,
      this.color});
  final int status;
  final String complaint;
  final String complaintId;
  final String date;
  final String department;
  final Color color;
  final String path;

  @override
  _MessageBubbleState createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  double width = 200;
  ComplaintStatus _status;
  @override
  void initState() {
    if (widget.status == 0) {
      _status = ComplaintStatus.Ongoing;
    } else if (widget.status == 2) {
      _status = ComplaintStatus.Transfer;
    } else if (widget.status == 3) {
      _status = ComplaintStatus.New;
    } else if (widget.status == 1) {
      _status = ComplaintStatus.Done;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.status);
    var date = DateFormat.yMMMEd().format(DateTime.parse(widget.date));
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      color: widget.color,
      child: Column(
        children: <Widget>[
          GestureDetector(
            child: ListTile(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(ComplaintDetails.routeName, arguments: {
                  'complaintId': widget.complaintId,
                  'path': widget.path,
                });
              },
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 6, horizontal: 23),
              leading: CircularAvatar(
                status: _status,
              ),
              title: Text(
                widget.complaint,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color,
                  fontSize: 14,
                  fontFamily: Theme.of(context).textTheme.bodyText1.fontFamily,
                ),
              ),
              subtitle: Text(
                date == null ? 'Formatted date' : date.toString(),
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color,
                  fontSize: 12,
                  fontFamily: Theme.of(context).textTheme.bodyText1.fontFamily,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
