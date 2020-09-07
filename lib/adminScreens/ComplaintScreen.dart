import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridabad/adminScreens/complaint_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/CircularAvatar.dart';
import '../data/complaint.dart';
import '../widgets/switch.dart';

class ComplaintScreen extends StatefulWidget {
  static const routeName = '/complaintScreen';
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

  final _auth = FirebaseAuth.instance;
  final databaseReference = Firestore.instance;
  String messageText;
  var uid;
  var ref;
  List<String> listOfReferences = [];
  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  @override
  void didChangeDependencies() {
    ref = ModalRoute.of(context).settings.arguments;
    // getComplaints(ref);

    super.didChangeDependencies();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        uid = user.uid;
        loggedInUser = user;
        email = loggedInUser.email;
        setState(() {});
      }
    } catch (e) {
      print(e);
    }
  }

  bool transfer = false;

  changeState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff15131E),
      body:
          Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 30, 2),
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
                        width: 1,
                        color: Colors.white,
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
                  
                      myGradient: LinearGradient(
                        colors: [
                          Color(0xffff4A2B),
                          Color(0xffFE7325),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
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
                        width: 1,
                        color: Colors.white,
                      ),
                    ),
                    child:
                        RollingSwitch(
                      value: ongoingValue,
                      textOff: 'Ongoing',
                      textOn: 'Ongoing',
                      onChanged: (v) {
                      },
                      onTap: () {
                        transferValue = false;
                        doneValue = false;
                        ongoingValue = !ongoingValue;
                        setState(() {});
                      },
                      colorOff: Colors.transparent,
                      colorOn: Color(0xfff4b601),
                      myGradient: LinearGradient(
                        colors: [
                          Color(0xfff4b601),
                          Color(0xffffee77),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        //         ),
                      ),
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
                        width: 1,
                        color: Colors.white,
                      ),
                    ),
                    child:
                        RollingSwitch(
                      textOff: 'New',
                      textOn: 'New',
                      onChanged: (v) {},
                      onTap: () {
                        transferValue = false;
                        newValue = !newValue;
                        doneValue  = false;
                        ongoingValue = false;
                        setState(() {});
                      },
                      value: newValue,
                      colorOff: Colors.transparent,
                      colorOn: Color.fromRGBO(77, 136, 242, 1),
                      myGradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(77, 137, 241, 1),
                          Color.fromRGBO(85, 167, 245, 1),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
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
                        width: 1,
                        color: Colors.white,
                      ),
                    ),
                    child:
                        RollingSwitch(
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
                      myGradient: LinearGradient(
                        colors: [
                          Color(0xff51b328),
                          Color(0xff85eb29),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: MessagesStream1(uid, transferValue, ongoingValue,
                    doneValue, listOfReferences, ref)),
          ],
        ),
      ),
    );
  }
}

class MessagesStream1 extends StatefulWidget {
  final uid;
  final transferValue;
  final ongoingValue;
  final doneValue;
  final listOfReferences;
  final department;
  MessagesStream1(this.uid, this.transferValue, this.ongoingValue,
      this.doneValue, this.listOfReferences, this.department);

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
            list = snapshot.data.documents.where((val) => (val['status'] == 1)).toList();
            // print(list);
          } else {
            list = snapshot.data.documents;
          }
          // print(list);
          return ListView.builder(
              key: GlobalKey(),
              itemCount: list.length,
              itemBuilder: (context, index) {
                return MessageBubble(
                  complaint: list[index]['subject'],
                  department: widget.department,
                  status: list[index]['status'].toString(),
                  complaintId: list[index]['ref'],
                  color: (index % 2 == 0)
                      ? Color.fromARGB(255, 33, 30, 43)
                      : Color(0xff15131E),
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
      this.color});
  final String status;
  final String complaint;
  final String complaintId;
  final String department;
  final Color color;

  @override
  _MessageBubbleState createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  double width = 200;
  ComplaintStatus _status;
  @override
  void initState() {
    if (widget.status == '0') {
      _status = ComplaintStatus.Ongoing;
    } else {
      _status = ComplaintStatus.Done;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      color: widget.color,
      child: Column(
        children: <Widget>[
          GestureDetector(
            child: ListTile(
              onTap: () {
                Navigator.of(context).pushNamed(ComplaintDetails.routeName,
                    arguments: widget.complaintId);
              },
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 6, horizontal: 23),
              leading: CircularAvatar(
                status: _status,
              ),
              title: Text(
                widget.complaint,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                'Formatted Date',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

