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
          if (true) {
            final status = message.data['status'];
            final author = message.data['author'];
            print(author);
            final complainttext = message.data['complaintText'];
            final department = message.data['department'];
            final complaintId = message.documentID;
            print('status $status');
            // print(imageUrl);
            final currentUser = loggedInUser.email;
            print('user = $currentUser');
            final messageBubble = MessageBubble(
              complaint: complainttext,
              status: status.toString(),
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
  });

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
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              print("tap");
              Navigator.of(context).pushNamed(ShowComplaint.routeName,
                  arguments: widget.complaintId);
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    widget.status == '0' ? Colors.blue[300] : Colors.green[300],
                    widget.status == '0' ? Colors.blue[200] : Colors.green[200],
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        // Text(
                        //   'Department: ',
                        //   style: TextStyle(
                        //     fontSize: 21.0,
                        //     color: Colors.black,
                        //   ),
                        // ),
                        // SizedBox(
                        //   width: 10,
                        // ),
                        Expanded(
                          child: Text(
                            ' ${widget.department}',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Icon(widget.status == '0'
                            ? Icons.watch_later
                            : Icons.done),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      '${widget.complaint}',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
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
