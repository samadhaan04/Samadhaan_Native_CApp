import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridabad/adminScreens/complaintDescriptionCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  @override
  void initState() {
    _firestore = Firestore.instance;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    complaintId = ModalRoute.of(context).settings.arguments;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 40),
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
                return Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 3),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          descExpansion(data['complaintText']),
                          imgExpansion(data['imageURL']),
                          logExpansion(),
                          // reqExpansion(),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Actions',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 60,
                            padding: EdgeInsets.all(15),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                            ),
                            child: TextField(
                              decoration: InputDecoration(

                              ),
                              style: TextStyle(
                                fontSize: 21,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          FlatButton(
                            child: Text(
                              "Feedback",
                              style: TextStyle(
                                fontSize: 23,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: (){},
                          )
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
                      fontSize: 20,
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
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.08),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15)),
                  padding: EdgeInsets.fromLTRB(25, 20, 25, 40),
                  child: Text(
                    complaint,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 19,
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
                style: TextStyle(fontSize: 20),
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
                      fontSize: 20,
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
                  child: ListView.builder(
                    key: GlobalKey(),
                    itemCount: images.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return imageBox(images[index]);
                    },
                  ),
                ),
              ),
            ],
          )
        : Row(
            children: <Widget>[
              Text(
                'Images',
                style: TextStyle(fontSize: 20),
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
    print(imageUrl);
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Image.network(imageUrl),
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
                      fontSize: 20,
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
              SizedBox(
                height: 5,
              ),
              SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.08),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15)),
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 30),
                  child: Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              )
            ],
          )
        : Row(
            children: <Widget>[
              Text(
                'Logs',
                style: TextStyle(fontSize: 20),
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
