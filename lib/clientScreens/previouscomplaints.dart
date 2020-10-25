import 'package:faridabad/data/constants.dart';
import 'package:faridabad/loginScreen.dart';
import 'package:faridabad/clientScreens/showcomplaintNew.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;
String email;
int sort = 0;

class PreviousComplaints extends StatefulWidget {
  static const routeName = '/previous-complaints';
  @override
  PreviousComplaintsState createState() => (PreviousComplaintsState());
}

class PreviousComplaintsState extends State<PreviousComplaints> {
// final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String messageText;
  var uid;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    setState(() {});
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        setState(() {
          uid = user.uid;
          loggedInUser = user;
          email = loggedInUser.email;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 10, top: 45),
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                    text: "Complaints",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 48,
                      letterSpacing: 1,
                      color: Color(0xff817f7f),
                    ),
                  ),
                ),
              ),
              MessagesStream(uid),
            ],
          ),
        ),
      ),
    );
  }
}

List<Widget> getBubbles(List list) {
  List<Widget> messageBubbles = [];
  if (list != null) {
    for (var l in list) {
      messageBubbles.add(Column(
        children: <Widget>[
          StreamBuilder(
            stream: _firestore.document(l['ref']).snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Container();
              } else {
                if (snapshot.data.data == null) {
                  return Center();
                } else
                  return MessageBubble(
                    subject: snapshot.data['subject'],
                    department: snapshot.data['department'],
                    status: snapshot.data['status'].toString(),
                    complaintId: snapshot.data.documentID,
                    index: list.indexOf(l),
                  );
              }
            },
          ),
        ],
      ));
    }
    return messageBubbles;
  } else {
    return null;
  }
}

class MessagesStream extends StatelessWidget {
  final uid;
  MessagesStream(this.uid);

  @override
  Widget build(BuildContext context) {
    // print('uid $uid');
    return StreamBuilder(
        stream:
            _firestore.collection('Users/$uid/previousComplaints').snapshots(),
        builder: (context, value) {
          if (!value.hasData) {
            return Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            final list = value.data.documents;
            var messageBubbles = getBubbles(list);
            // print('l ${list.length}');
            if (messageBubbles.length == 0) {
              return Expanded(
                child: Center(
                  child: Text(
                    "No Complaints Yet !!!",
                    style: TextStyle(fontSize: 21),
                  ),
                ),
              );
            }
            return Expanded(
              flex: 1,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                children: messageBubbles,
              ),
            );
          }
        });
  }
}

class MessageBubble extends StatefulWidget {
  MessageBubble({
    this.status,
    this.subject,
    this.complaintId,
    this.department,
    this.index,
  });
  final String status;
  final String subject;
  final String complaintId;
  final String department;
  final index;
  @override
  _MessageBubbleState createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  TextEditingController _controller = new TextEditingController();
  String _selectedDepartment;
  Color _color = Colors.red;
  double width = 200;
  String _status;
  @override
  Widget build(BuildContext context) {
    print('index ${widget.index}');
    return Container(
      key: GlobalKey(),
      margin: EdgeInsets.all(5),
      child: Column(
        key: GlobalKey(),
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(ShowComplaintsNew.routeName,
                  arguments: widget.complaintId);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: widget.index % 2 == 0
                    ? Colors.white
                    : Color.fromRGBO(244, 244, 244, 1),
                border: widget.index % 2 != 0
                    ? null
                    : Border.all(
                        color: Colors.grey[300],
                      ),
              ),
              child: Container(
                  padding: EdgeInsets.all(15),
                  child: Container(
                    width: double.infinity,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: widget.status == "0"
                              ? Color.fromRGBO(240, 207, 98, 1)
                              : widget.status == "1"
                                  ? Color.fromRGBO(132, 202, 74, 1)
                                  : widget.status == "2"
                                      ? Color.fromRGBO(235, 103, 60, 1)
                                      : Color.fromRGBO(82, 153, 253, 1),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Text(
                            widget.subject,
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
