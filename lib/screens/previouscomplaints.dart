import 'package:faridabad/data/constants.dart';
import 'package:faridabad/screens/home.dart';
import 'package:faridabad/screens/showcomplaint.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;
String email;
int sort = 0;

class PreviousComplanints extends StatefulWidget {
  static const routeName = '/previous-complaints';
  @override
  PreviousComplanintsState createState() => (PreviousComplanintsState());
}

class PreviousComplanintsState extends State<PreviousComplanints> {
  // final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        email = loggedInUser.email;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 4,
        title: FittedBox(
          fit: BoxFit.contain,
          child: RichText(
            text: TextSpan(
                text: "COMPLA",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    letterSpacing: 1,
                    color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: "INTS",
                      style: TextStyle(
                          letterSpacing: 1,
                          fontSize: 35,
                          color: Colors.grey[500],
                          fontFamily: "Sans Serif"))
                ]),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MessagesStream(),
            ],
          ),
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.collection('Complaints').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        print("snapshot $snapshot");
        final messages = snapshot.data.documents;
        print('messages $messages');
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          if (message.data['author'] == loggedInUser.uid) {
            final status = message.data['status'];
            final complainttext = message.data['complaintText'];
            final imageUrl = message.data['imageURL'];
            final department = message.data['department'];
            final complaintId = message.documentID;
            print('id $complaintId');
            // print(imageUrl);
            final currentUser = loggedInUser.email;
            print('user = $currentUser');
            final messageBubble = MessageBubble(
              complaint: complainttext,
              status: status.toString(),
              imageUrl: imageUrl,
              department: department,
              complaintId: complaintId,
            );
            messageBubbles.add(messageBubble);
          }
        }

        return Expanded(
          flex: 1,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatefulWidget {
  MessageBubble({
    this.status,
    this.complaint,
    this.complaintId,
    this.department,
    this.imageUrl,
  });

  final String imageUrl;
  final String status;
  final String complaint;
  final String complaintId;
  final String department;

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
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              print("tap");
              Navigator.of(context).pushNamed(ShowComplaint.routeName,
                  arguments: widget.complaintId);
            },
            child: Card(
              elevation: 10,
              color: Colors.grey[100],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                      color: Colors.grey[300],
                      child: Image.network(
                        widget.imageUrl,
                        fit: BoxFit.contain,
                        height: 250,
                      )),
                  // Container(
                  //   child: Padding(
                  //     padding: EdgeInsets.all(15),
                  //     child: Text(
                  //       '${widget.status}',
                  //       style: TextStyle(
                  //         fontSize: 18.0,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Container(
                    color: Colors.blueGrey,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            // Row(
                            //   children: <Widget>[
                            //     Text(
                            //       'Name:',
                            //       style: TextStyle(
                            //         fontSize: 18.0,
                            //         fontWeight: FontWeight.bold,
                            //         color: Colors.black87,
                            //       ),
                            //     ),
                            //     Text(
                            //       // ' ${widget.name}',
                            //       "empty",
                            //       style: TextStyle(
                            //         fontSize: 18.0,
                            //         color: Colors.black87,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // Row(
                            //   children: <Widget>[
                            //     Text(
                            //       'Phone Number:',
                            //       style: TextStyle(
                            //         fontSize: 18.0,
                            //         fontWeight: FontWeight.bold,
                            //         color: Colors.black87,
                            //       ),
                            //     ),
                            //     Text(
                            //       // ' ${widget.phone}',
                            //       "empty",
                            //       style: TextStyle(
                            //         fontSize: 18.0,
                            //         color: Colors.black87,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // Row(
                            //   crossAxisAlignment: CrossAxisAlignment.baseline,
                            //   textBaseline: TextBaseline.alphabetic,
                            //   children: <Widget>[
                            //     Text(
                            //       'Address: ',
                            //       style: TextStyle(
                            //         fontSize: 18.0,
                            //         fontWeight: FontWeight.bold,
                            //         color: Colors.black87,
                            //       ),
                            //       maxLines: 20,
                            //     ),
                            //     Container(
                            //       child: Expanded(
                            //         child: Text(
                            //           // '${widget.address}',
                            //           "empty",
                            //           style: TextStyle(
                            //             fontSize: 18.0,
                            //             color: Colors.black87,
                            //           ),
                            //           maxLines: 20,
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // Row(
                            //   children: <Widget>[
                            //     Text(
                            //       'Date:',
                            //       style: TextStyle(
                            //         fontSize: 18.0,
                            //         fontWeight: FontWeight.bold,
                            //         color: Colors.black87,
                            //       ),
                            //     ),
                            //     Text(
                            //       // ' ${widget.date}',
                            //       "empty",
                            //       style: TextStyle(
                            //         fontSize: 18.0,
                            //         color: Colors.black87,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: <Widget>[
                                Text(
                                  'Department: ',
                                  style: TextStyle(
                                    fontSize: 21.0,
                                    color: Colors.white,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    ' ${widget.department}',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: <Widget>[
                                Text(
                                  'Complaint: ',
                                  style: TextStyle(
                                    fontSize: 21.0,
                                    color: Colors.white,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    ' ${widget.complaint}',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Row(
                            //   crossAxisAlignment: CrossAxisAlignment.baseline,
                            //   textBaseline: TextBaseline.alphabetic,
                            //   children: <Widget>[
                            //     Text(
                            //       'Admin Remark:',
                            //       style: TextStyle(
                            //         fontSize: 18.0,
                            //         fontWeight: FontWeight.bold,
                            //         color: Colors.black87,
                            //       ),
                            //     ),
                            //     Expanded(
                            //       child: Text(
                            //         // ' ${widget.adminremark}',
                            //         "empty",
                            //         style: TextStyle(
                            //           fontSize: 18.0,
                            //           color: Colors.black87,
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // Row(
                            //   children: <Widget>[
                            //     Text(
                            //       'Dept Remark:',
                            //       style: TextStyle(
                            //         fontSize: 18.0,
                            //         fontWeight: FontWeight.bold,
                            //         color: Colors.black87,
                            //       ),
                            //     ),
                            //     Expanded(
                            //       child: Text(
                            //         // ' ${widget.deptremark}',
                            //         "empty",
                            //         style: TextStyle(
                            //           fontSize: 18.0,
                            //           color: Colors.black87,
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
