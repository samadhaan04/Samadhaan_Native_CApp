import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridabad/adminScreens/complaintDescriptionCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/showModal.dart';

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
  var ref;
  Firestore _firestore;

  @override
  void initState() {
    _firestore = Firestore.instance;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    ref = ModalRoute.of(context).settings.arguments;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                return Column(
                  children: <Widget>[
                    ReusableCardComplaint(
                      colour: Theme.of(context).disabledColor,
                      // Color(0xff1d1b27),
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
                                  fontSize: 18,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .color,
                                ),
                              ),
                              CircleAvatar(
                                radius: 15,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xffFF4A2B),
                                        Color(0xffFE7325),
                                      ],
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
                              fontSize: 22,
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
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .color,
                                  fontSize: 20,
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
                          imgExpansion(data['imageURL']),
                          logExpansion(),
                          reqExpansion(),
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
                      fontSize: 20,
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
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15)),
                  padding: EdgeInsets.fromLTRB(25, 20, 25, 40),
                  child: Text(
                    complaint,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 19,
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
                      fontSize: 20,
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
      // decoration: BoxDecoration(
      //   border: Border.all(
      //     color: Colors.black,
      //   ),
      // ),
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
                      color: Theme.of(context).textTheme.bodyText1.color,
                      fontSize: 20,
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
              SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15)),
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 30),
                  child: Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 20,
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

  //************************************************REQUEST*********************************************/

  Widget reqExpansion() {
    TextEditingController request = TextEditingController();
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
                      maxLines: 4,
                      controller: request,
                      minLines: 1,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ShowModalDrop(), //FUNCTION***************************//
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      UtilButton(
                        childtext: 'Dismiss Request',
                        onpress: () {},
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      UtilButton(
                        childtext: 'Confirm Action',
                        onpress: () {},
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
