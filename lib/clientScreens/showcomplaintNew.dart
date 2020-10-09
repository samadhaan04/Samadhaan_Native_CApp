import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridabad/adminScreens/complaintDescriptionCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/showModal.dart';

class ShowComplaintsNew extends StatefulWidget {
  static const routeName = '/show-complaintNew';

  @override
  _ShowComplaintsNewState createState() => _ShowComplaintsNewState();
}

class _ShowComplaintsNewState extends State<ShowComplaintsNew> {
  bool expandedDesc = true;
  bool expandedImg = true;
  bool expandedLog = true;
  bool expandedReq = true;
  String complaintId;
  Firestore _firestore;
  List logs;
  String logsText;
  var name;

  TextEditingController feedback = TextEditingController();

  @override
  void initState() {
    _firestore = Firestore.instance;
    setName();
    super.initState();
  }

  void setName() async {
    var pref = await SharedPreferences.getInstance();
    name = pref.getString('name');
  }

  @override
  void didChangeDependencies() {
    complaintId = ModalRoute.of(context).settings.arguments;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: StreamBuilder<DocumentSnapshot>(
            stream: Firestore.instance
                .collection('Complaints')
                .document(complaintId)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                var data = snapshot.data.data;
                logs = data['logs'];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.12,
                        width: MediaQuery.of(context).size.width,
                        color: Color(0xf5f5f5f5),
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.03,
                            ),
                            child: Text(
                              data['subject'],
                              style: TextStyle(
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.left,
                              softWrap: true,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                      child: Column(
                        children: <Widget>[
                          descExpansion(data['complaintText']),
                          // SizedBox(
                          //   height: 5,
                          // ),
                          logs.length != 0 ? logExpansion() : Container(),
                          data['imageURL'] != null
                              ? imgExpansion(data['imageURL'])
                              : Container(),
                          // reqExpansion(),
                          SizedBox(
                            height: 12,
                          ),
                          data['status'] != 1 ? actionExpansion() : Container(),
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

  void sendFeedback() {
    logs.add('$name : ${feedback.text}');
    Firestore.instance
        .collection('Complaints')
        .document(complaintId)
        .updateData({
      'userFeedback': feedback.text,
      'logs': logs,
    }).then((value) {
      setState(() {
        feedback.text = '';
      });
    });
  }

  Widget actionExpansion() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'Actions',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Color(0xff817F7F),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter Feedback',
                border: InputBorder.none,
              ),
              maxLines: null,
              style: TextStyle(
                fontSize: 15,
              ),
              textAlign: TextAlign.start,
              controller: feedback,
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        FlatButton(
          child: Text(
            "Feedback",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Color(0xff817F7F),
            ),
          ),
          onPressed: () {
            sendFeedback();
          },
        )
      ],
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
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Color(0xff817F7F),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.expand_less,
                      size: 40,
                      color: Colors.black.withOpacity(0.5),
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
                  // decoration: BoxDecoration(
                  //     color: Colors.black.withOpacity(0.08),
                  //     shape: BoxShape.rectangle,
                  //     borderRadius: BorderRadius.circular(15)),
                  // padding: EdgeInsets.fromLTRB(25, 20, 25, 40),
                  child: Text(
                    complaint,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 15,
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
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color(0xff817F7F),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.expand_more,
                  size: 40,
                  color: Colors.black.withOpacity(0.5),
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
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Color(0xff817F7F),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.expand_less,
                      size: 40,
                      color: Colors.black.withOpacity(0.5),
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
                    // margin: EdgeInsets.symmetric(vertical: 10),
                    child: images != null
                        ? ListView.builder(
                            key: GlobalKey(),
                            itemCount: images.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return imageBox(images[index]);
                            },
                          )
                        : Container()),
              ),
            ],
          )
        : Row(
            children: <Widget>[
              Text(
                'Images',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color(0xff817F7F),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.expand_more,
                  size: 40,
                  color: Colors.black.withOpacity(0.5),
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
        onTap: () {
          showDialog(
            context: context,
            child: AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Hero(
                tag: 'image',
                child: Image.network(imageUrl),
              ),
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
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Color(0xff817F7F),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.expand_less,
                      size: 40,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    onPressed: () {
                      setState(() {
                        expandedLog = !expandedLog;
                      });
                    },
                  )
                ],
              ),
              Container(
                width: double.infinity,
                height: logs.length * 20.0 < 150.0 ? logs.length * 20.0 : 150,
                child: ListView.builder(
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  itemCount: logs.length,
                  itemBuilder: (context, index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
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
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
              // Container(
              //   height: logs.length * 20.0 < 150.0 ? logs.length * 20.0 : 150,
              //   child: ListView.builder(
              //     padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              //     shrinkWrap: true,
              //     itemCount: logs.length,
              //     itemBuilder: (context, index) {
              //       return Row(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Container(
              //             decoration: BoxDecoration(
              //               shape: BoxShape.circle,
              //               color: Colors.black,
              //             ),
              //             height: 5,
              //             width: 20,
              //           ),
              //           SizedBox(
              //             width: 10,
              //           ),
              //           Text(
              //             logs[index],
              //             style: TextStyle(color: Colors.black),
              //           )
              //         ],
              //       );
              //     },
              //   ),
              // )
            ],
          )
        : Row(
            children: <Widget>[
              Text(
                'Logs',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color(0xff817F7F),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.expand_more,
                  size: 40,
                  color: Colors.black.withOpacity(0.5),
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
}
