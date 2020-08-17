import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridabad/screens/complaint_details.dart';
import 'package:faridabad/screens/prevtest.dart';
import 'package:faridabad/screens/showcomplaint.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'screens/CircularAvatar.dart';
import 'screens/complaint.dart';
import 'widgets/switch.dart';

class AdminApp extends StatefulWidget {
  static const routeName = '/admin-app';
  @override
  _AdminAppState createState() => _AdminAppState();
}

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;
String email;
int sort = 0;

class _AdminAppState extends State<AdminApp> {
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

  // void getComplaints(String department) async {
  //   // print(department);

  //   await databaseReference
  //       .collection('States/Haryana/Palwal/$department/Complaints')
  //       .getDocuments()
  //       .then((value) {
  //     value.documents.forEach((element) {
  //       // print(element.data['ref']);
  //       String d = element.data['ref'];
  //       listOfReferences.add(d);
  //       // databaseReference.document(d).get().then((value) {
  //       // print(value.data);
  //       // });
  //     });
  //   });
  //   // await databaseReference
  //   //     .collection('States/Haryana/Palwal/$department/Complaints')
  //   //     .getDocuments()
  //   //     .then((value) {
  //   //       print(value.documents);
  //   //       value.documents.forEach((element) {
  //   //         // print(element.data['ref']);
  //   //         var d = element.data['ref'];
  //   //         print(d);
  //   //         listOfReferences.add(d);
  //   //         // databaseReference.document(d).get().then((value) {
  //   //             // print(value.data);
  //   //           // });
  //   //        });
  //   // });
  // }

  // final complaints = [
  //   Complaint(
  //     complaint: 'Complaint 1',
  //     status: ComplaintStatus.Transfer,
  //   ),
  //   Complaint(
  //     complaint:
  //         'This is a sample text to check if this works. I hope it does!',
  //     status: ComplaintStatus.Ongoing,
  //   ),
  //   Complaint(
  //     complaint: 'Complaint 3',
  //     status: ComplaintStatus.Transfer,
  //   ),
  //   Complaint(
  //     complaint: 'Complaint 4',
  //     status: ComplaintStatus.New,
  //   ),
  //   Complaint(
  //     complaint: 'Complaint 5',
  //     status: ComplaintStatus.Done,
  //   ),
  //   Complaint(
  //     complaint: 'Complaint 6',
  //     status: ComplaintStatus.New,
  //   ),
  //   Complaint(
  //     complaint: 'Complaint 7',
  //     status: ComplaintStatus.Done,
  //   ),
  //   Complaint(
  //     complaint: 'Complaint 8',
  //     status: ComplaintStatus.Transfer,
  //   ),
  //   Complaint(
  //     complaint: 'Complaint 9',
  //     status: ComplaintStatus.Ongoing,
  //   ),
  //   Complaint(
  //     complaint: 'Complaint 10',
  //     status: ComplaintStatus.New,
  //   ),
  // ];

  bool transfer = false;

  changeState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff15131E),
      body:
          //padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
          // rgb(33, 30, 43)
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
                      // iconOff: Icons.transfer_within_a_station,
                      // iconOn: Icons.transfer_within_a_station,
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
                        // Text('hello', style: TextStyle(color: Colors.white),),
                        RollingSwitch(
                      value: ongoingValue,
                      textOff: 'Ongoing',
                      textOn: 'Ongoing',
                      onChanged: (v) {
                        // print('v $v');
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
                  //Expanded(
                  // Container(
                  //   margin: const EdgeInsets.only(right: 15, left: 20),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(50),
                  //     border: Border.all(
                  //       width: 1,
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  //   child:
                  // Chip(
                  //   avatar: CircleAvatar(
                  //     child: Container(
                  //       decoration: BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         gradient: LinearGradient(
                  //           colors: [
                  //             Color(0xff3d84fa),
                  //             Color(0xff34afff),
                  //           ],
                  //           begin: Alignment.centerLeft,
                  //           end: Alignment.centerRight,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  //   label: Text(
                  //     'New',
                  //     style: TextStyle(
                  //       color: Colors.grey,
                  //       fontSize: 16,
                  //     ),
                  //   ),
                  //   labelPadding: const EdgeInsets.fromLTRB(4, 10, 55, 6),
                  //   backgroundColor: Color(0xff0a0e18),
                  // ),
                  //       RollingSwitch(
                  //     textOff: 'New',
                  //     textOn: 'New',
                  //     onChanged: (v) {
                  //       // setState(() {
                  //         if (v)
                  //           newValue = true;
                  //         else
                  //           newValue = false;
                  //       // });
                  //     },
                  //     value: newValue,
                  //     colorOff: Colors.transparent,
                  //     colorOn: Color(0xff34afff),
                  //     myGradient: LinearGradient(
                  //       colors: [
                  //         Color(0xff3d84fa),
                  //         Color(0xff34afff),
                  //       ],
                  //       begin: Alignment.centerLeft,
                  //       end: Alignment.centerRight,
                  //     ),
                  //   ),
                  // ),
                  // //),
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width * 0.001,
                  // ),
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
                        // Chip(
                        //   avatar: CircleAvatar(
                        //     child: Container(
                        //       decoration: BoxDecoration(
                        //         shape: BoxShape.circle,
                        //         gradient: LinearGradient(
                        //           colors: [
                        //             Color(0xff51b328),
                        //             Color(0xff85eb29),
                        //           ],
                        //           begin: Alignment.centerLeft,
                        //           end: Alignment.centerRight,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        //   label: Text(
                        //     'Done',
                        //     style: TextStyle(
                        //       color: Colors.grey,
                        //       fontSize: 16,
                        //     ),
                        //   ),
                        //   labelPadding: const EdgeInsets.fromLTRB(4, 10, 49, 6),
                        //   backgroundColor: Color(0xff0a0e18),
                        // ),
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
                  //),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: MessagesStream1(uid, transferValue, ongoingValue,
                    doneValue, listOfReferences, ref)),
            // child: MessagesStream(uid, transferValue, ongoingValue,
            //     doneValue, listOfReferences)),
            // Expanded(
            //   child: ListView.builder(
            //     itemBuilder: (context, index) => Container(
            //       padding: EdgeInsets.symmetric(vertical: 5),
            //       color: (index % 2 == 0)
            //           ? Color.fromARGB(255, 33, 30, 43)
            //           : Color(0xff15131E),
            //       // Color(0xff0a0e18),
            //       // elevation: 10,
            //       // child: Container(
            //       //   decoration: BoxDecoration(
            //       //     border: Border.all(
            //       //       color: Colors.black,
            //       //       width: 2,
            //       //     ),
            //       //     borderRadius: BorderRadius.circular(50),
            //       //   ),
            //       child: ListTile(
            //         //dense: true,
            //         onTap: () {},
            //         contentPadding:
            //             const EdgeInsets.symmetric(vertical: 6, horizontal: 23),
            //         leading: CircularAvatar(
            //           status: complaints[index].status,
            //         ),
            //         title: Text(
            //           complaints[index].complaint,
            //           style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 18,
            //           ),
            //         ),
            //         subtitle: Text(
            //           'Formatted Date',
            //           style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 12,
            //           ),
            //         ),
            //       ),
            //       //),
            //     ),
            //     itemCount: complaints.length,
            //   ),
            // ),
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
          // setState(() {
          //   loading = true;
          // });
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
      // height: 100,
      color: widget.color,
      // Container(
      //             padding: EdgeInsets.symmetric(vertical: 5),
      //             color: (index % 2 == 0)
      //                 ? Color.fromARGB(255, 33, 30, 43)
      //                 : Color(0xff15131E),
      //             Color(0xff0a0e18),
      //             elevation: 10,
      //             child: Container(
      //               decoration: BoxDecoration(
      //                 border: Border.all(
      //                   color: Colors.black,
      //                   width: 2,
      //                 ),
      //                 borderRadius: BorderRadius.circular(50),
      //               ),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              // Navigator.of(context).pushNamed(ComplaintDetails.routename,
              //     arguments: widget.complaintId);
            },
            child: ListTile(
              // decoration: BoxDecoration(
              //   gradient: LinearGradient(
              //     colors: [
              //       widget.status == '0' ? Colors.blue[300] : Colors.green[300],
              //       widget.status == '0' ? Colors.blue[200] : Colors.green[200],
              //     ],
              //     begin: Alignment.topCenter,
              //     end: Alignment.bottomCenter,
              //   ),
              //   borderRadius: BorderRadius.circular(15),
              // ),
              // ListTile(
              //       //dense: true,
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
            // child: Container(
            // padding: EdgeInsets.all(30),
            // child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: <Widget>[
            //       Row(
            //         children: <Widget>[
            //           Expanded(
            //             child: Text(
            //               ' ${widget.department}',
            //               style: TextStyle(
            //                   fontSize: 20.0,
            //                   color: Colors.black,
            //                   fontWeight: FontWeight.bold),
            //             ),
            //           ),
            //           Icon(widget.status == '0'
            //               ? Icons.watch_later
            //               : Icons.done),
            //         ],
            //       ),
            //       SizedBox(
            //         height: 30,
            //       ),
            //       Text(
            //         '${widget.complaint}',
            //         style: TextStyle(
            //           fontSize: 18.0,
            //           color: Colors.black,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ),
          // SizedBox(
          //   height: 5,
          // ),
        ],
      ),
    );
  }
}

// class MessageBubble1 extends StatefulWidget {
//   MessageBubble1(
//       {this.status,
//       this.complaint,
//       this.complaintId,
//       this.department,
//       this.color});
//   final String status;
//   final String complaint;
//   final String complaintId;
//   final String department;
//   final Color color;

//   @override
//   _MessageBubble1State createState() => _MessageBubble1State();
// }

// class _MessageBubble1State extends State<MessageBubble1> {
//   double width = 200;
//   ComplaintStatus _status;
//   @override
//   void initState() {
//     if (widget.status == '0') {
//       _status = ComplaintStatus.Ongoing;
//     } else {
//       _status = ComplaintStatus.Done;
//     }
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 5),
//       // height: 100,
//       color: widget.color,
//       // Container(
//       //             padding: EdgeInsets.symmetric(vertical: 5),
//       //             color: (index % 2 == 0)
//       //                 ? Color.fromARGB(255, 33, 30, 43)
//       //                 : Color(0xff15131E),
//       //             Color(0xff0a0e18),
//       //             elevation: 10,
//       //             child: Container(
//       //               decoration: BoxDecoration(
//       //                 border: Border.all(
//       //                   color: Colors.black,
//       //                   width: 2,
//       //                 ),
//       //                 borderRadius: BorderRadius.circular(50),
//       //               ),
//       child: Column(
//         children: <Widget>[
//           GestureDetector(
//             onTap: () {
//               // Navigator.of(context).pushNamed(ComplaintDetails.routename,
//               //     arguments: widget.complaintId);
//               print('hello');
//             },
//             child: ListTile(
//               // decoration: BoxDecoration(
//               //   gradient: LinearGradient(
//               //     colors: [
//               //       widget.status == '0' ? Colors.blue[300] : Colors.green[300],
//               //       widget.status == '0' ? Colors.blue[200] : Colors.green[200],
//               //     ],
//               //     begin: Alignment.topCenter,
//               //     end: Alignment.bottomCenter,
//               //   ),
//               //   borderRadius: BorderRadius.circular(15),
//               // ),
//               // ListTile(
//               //       //dense: true,
//               onTap: () {
//                 Navigator.of(context).pushNamed(ComplaintDetails.routename,
//                     arguments: widget.complaintId);
//               },
//               contentPadding:
//                   const EdgeInsets.symmetric(vertical: 6, horizontal: 23),
//               leading: CircularAvatar(
//                 status: _status,
//               ),
//               title: Text(
//                 widget.complaint,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                 ),
//               ),
//               subtitle: Text(
//                 'Formatted Date',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 12,
//                 ),
//               ),
//             ),
//             // child: Container(
//             // padding: EdgeInsets.all(30),
//             // child: Column(
//             //     crossAxisAlignment: CrossAxisAlignment.start,
//             //     children: <Widget>[
//             //       Row(
//             //         children: <Widget>[
//             //           Expanded(
//             //             child: Text(
//             //               ' ${widget.department}',
//             //               style: TextStyle(
//             //                   fontSize: 20.0,
//             //                   color: Colors.black,
//             //                   fontWeight: FontWeight.bold),
//             //             ),
//             //           ),
//             //           Icon(widget.status == '0'
//             //               ? Icons.watch_later
//             //               : Icons.done),
//             //         ],
//             //       ),
//             //       SizedBox(
//             //         height: 30,
//             //       ),
//             //       Text(
//             //         '${widget.complaint}',
//             //         style: TextStyle(
//             //           fontSize: 18.0,
//             //           color: Colors.black,
//             //         ),
//             //       ),
//             //     ],
//             //   ),
//             // ),
//           ),
//           // SizedBox(
//           //   height: 5,
//           // ),
//         ],
//       ),
//     );
//   }
// }

// ListView getBubbles(list) {
//   print('hello enter');
//   ListView messageBubbles;
//   // if (list != null) {
//   // for (var l in list) {
//   messageBubbles = (

//   // }
//   return messageBubbles;
//   // } else {
//   // return null;
//   // }
// }

// class MessagesStream extends StatefulWidget {
//   final uid;
//   final transferValue;
//   final ongoingValue;
//   final doneValue;
//   final listOfReferences;
//   MessagesStream(this.uid, this.transferValue, this.ongoingValue,
//       this.doneValue, this.listOfReferences);

//   @override
//   _MessagesStreamState createState() => _MessagesStreamState();
// }

// class _MessagesStreamState extends State<MessagesStream> {
//   @override
//   Widget build(BuildContext context) {
//     // print('uid ${widget.uid}');
//     return StreamBuilder(
//         stream: _firestore.collection('Complaints/').snapshots(),
//         // .snapshots(),
//         builder: (context, value) {
//           if (!value.hasData || value.data.documents.length == 0) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else {
//             var list;
//             if (widget.ongoingValue) {
//               // print("ongoing ${widget.ongoingValue}");
//               list = value.data.documents
//                   .where((e) => (e.data['status'] == 0))
//                   .toList();
//               // print(list.length);
//             } else if (widget.doneValue) {
//               // print("done ${widget.doneValue}");
//               list = value.data.documents
//                   .where((e) => (e.data['status'] == 1))
//                   .toList();
//               // print(list.length);
//             } else {
//               list = value.data.documents;
//             }
//             return ListView.builder(
//                 key: GlobalKey(),
//                 itemCount: list.length,
//                 itemBuilder: (context, index) {
//                   // print(list[index].documentID);
//                   return MessageBubble(
//                     complaint: list[index].data['complaintText'],
//                     department: list[index].data['department'],
//                     status: list[index].data['status'].toString(),
//                     complaintId: list[index].documentID,
//                     color: (index % 2 == 0)
//                         ? Color.fromARGB(255, 33, 30, 43)
//                         : Color(0xff15131E),
//                   );

//                   // var messageBubbles = getBubbles(list);
//                   // return Text('test');
//                   // if (messageBubbles == null) {
//                   //   return Expanded(
//                   //     child: Center(
//                   //       child: Text(
//                   //         "No Complaints Yet !!!",
//                   //         style: TextStyle(fontSize: 21),
//                   //       ),
//                   //     ),
//                   //   );
//                   // }
//                   // return Expanded(
//                   //   flex: 1,
//                   //   child: Container(
//                   //     padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
//                   //     child: messageBubbles,
//                   //   ),
//                   // );
//                   // if (ongoingValue) {
//                   //   return ListView.builder(
//                   //       itemCount: list.length,
//                   //       itemBuilder: (context, index) {
//                   //         // return StreamBuilder(
//                   //         //   stream: _firestore
//                   //         //       .document('Complaints/${list[index].documentID}')
//                   //         //       .snapshots(),
//                   //         //   builder: (BuildContext context, AsyncSnapshot snapshot) {
//                   //         //     if (!snapshot.hasData) {
//                   //         //       return Center(
//                   //         //         child: CircularProgressIndicator(),
//                   //         //       );
//                   //         //     } else {
//                   //         //       return MessageBubble(
//                   //         //         complaint: snapshot.data['complaintText'],
//                   //         //         department: snapshot.data['department'],
//                   //         //         status: snapshot.data['status'].toString(),
//                   //         //         complaintId: snapshot.data.documentID,
//                   //         //         color: (index % 2 == 0)
//                   //         //             ? Color.fromARGB(255, 33, 30, 43)
//                   //         //             : Color(0xff15131E),
//                   //         //       );
//                   //         //     }
//                   //         //   },
//                   //         // );
//                   //         if (list[index].data['status'] == '0') {
//                   //           return MessageBubble(
//                   //             complaint: list[index].data['complaintText'],
//                   //             department: list[index].data['department'],
//                   //             status: list[index].data['status'].toString(),
//                   //             complaintId: list[index].documentID,
//                   //             color: (index % 2 == 0)
//                   //                 ? Color.fromARGB(255, 33, 30, 43)
//                   //                 : Color(0xff15131E),
//                   //           );
//                   //         } else {
//                   //           return Center(
//                   //             child: CircularProgressIndicator(),
//                   //           );
//                   //         }
//                   //       });
//                   // }
//                   // if (transferValue) {
//                   //   return ListView.builder(
//                   //       itemCount: list.length,
//                   //       itemBuilder: (context, index) {
//                   //         // return StreamBuilder(
//                   //         //   stream: _firestore
//                   //         //       .document('Complaints/${list[index].documentID}')
//                   //         //       .snapshots(),
//                   //         //   builder: (BuildContext context, AsyncSnapshot snapshot) {
//                   //         //     if (!snapshot.hasData) {
//                   //         //       return Center(
//                   //         //         child: CircularProgressIndicator(),
//                   //         //       );
//                   //         //     } else {
//                   //         //       return MessageBubble(
//                   //         //         complaint: snapshot.data['complaintText'],
//                   //         //         department: snapshot.data['department'],
//                   //         //         status: snapshot.data['status'].toString(),
//                   //         //         complaintId: snapshot.data.documentID,
//                   //         //         color: (index % 2 == 0)
//                   //         //             ? Color.fromARGB(255, 33, 30, 43)
//                   //         //             : Color(0xff15131E),
//                   //         //       );
//                   //         //     }
//                   //         //   },
//                   //         // );
//                   //         if (list[index].data['status'] == '1') {
//                   //           return MessageBubble(
//                   //             complaint: list[index].data['complaintText'],
//                   //             department: list[index].data['department'],
//                   //             status: list[index].data['status'].toString(),
//                   //             complaintId: list[index].documentID,
//                   //             color: (index % 2 == 0)
//                   //                 ? Color.fromARGB(255, 33, 30, 43)
//                   //                 : Color(0xff15131E),
//                   //           );
//                   //         } else {
//                   //           return Center(
//                   //             child: CircularProgressIndicator(),
//                   //           );
//                   //         }
//                   //       });
//                   // } else {

//                   // return StreamBuilder(
//                   //   stream: _firestore
//                   //       .document('Complaints/${list[index].documentID}')
//                   //       .snapshots(),
//                   //   builder: (BuildContext context, AsyncSnapshot snapshot) {
//                   //     if (!snapshot.hasData) {
//                   //       return Center(
//                   //         child: CircularProgressIndicator(),
//                   //       );
//                   //     } else {
//                   //       return MessageBubble(
//                   //         complaint: snapshot.data['complaintText'],
//                   //         department: snapshot.data['department'],
//                   //         status: snapshot.data['status'].toString(),
//                   //         complaintId: snapshot.data.documentID,
//                   //         color: (index % 2 == 0)
//                   //             ? Color.fromARGB(255, 33, 30, 43)
//                   //             : Color(0xff15131E),
//                   //       );
//                   //     }
//                   //   },
//                   // );
//                 });
//             // }
//           }
//         });
//   }
// }

// // return ListView.builder(key: GlobalKey(),
// //       itemCount: widget.listOfReferences.length,
// //       itemBuilder: (context, index) {
// //         return
// //       });
