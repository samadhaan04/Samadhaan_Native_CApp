import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridabad/screens/reusable_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ComplaintDetails extends StatefulWidget {
  static const routeName = '/complaint-details';

  @override
  _ComplaintDetailsState createState() => _ComplaintDetailsState();
}

class _ComplaintDetailsState extends State<ComplaintDetails> {
  bool expandedDesc = false;
  bool expandedImg = false;
  bool expandedLog = false;
  bool expandedReq = false;
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
                      colour: Color(0xff1d1b27),
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
                                  color: Colors.grey[300],
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
                                  color: Colors.grey[400],
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
                          imgExpansion(),
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
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.expand_less,
                      size: 40,
                      color: Colors.white.withOpacity(0.5),
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
                  color: Colors.white.withOpacity(0.5),
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

  Widget imgExpansion() {
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
                      color: Colors.white.withOpacity(0.5),
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
                child: Container(),
              )
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
                  color: Colors.white.withOpacity(0.5),
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
                      color: Colors.white.withOpacity(0.5),
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
                  color: Colors.white.withOpacity(0.5),
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
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.expand_less,
                      size: 40,
                      color: Colors.white.withOpacity(0.5),
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
                    // child: Text(
                    //   'Lorem Ipsum is simply dummy text of the printing and typesetting industry.printing and typesetting industry.',
                    //   softWrap: true,
                    //   style: TextStyle(
                    //     fontSize: 20,
                    //   ),
                    // ),
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
                  )
                ],
              )
            ],
          )
        : Row(
            children: <Widget>[
              Text(
                'Request',
                style: TextStyle(fontSize: 20),
              ),
              IconButton(
                icon: Icon(
                  Icons.expand_more,
                  size: 40,
                  color: Colors.white.withOpacity(0.5),
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
//*************************************************SHOW MODAL DROP ************************************************//

class ShowModalDrop extends StatefulWidget {
  @override
  _ShowModalDropState createState() => _ShowModalDropState();
}

class _ShowModalDropState extends State<ShowModalDrop> {
  String _selected = 'Select Action';
  List<String> items = [
    'Electricity',
    'Education',
    'Agriculture',
    'Animal Husbandry',
    'Forestry',
    'Irrigation',
    'Check',
    'Post',
  ];
  int selectitem = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
      width: 330,
      height: 30,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 70),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: GestureDetector(
                onTap: () => showModal(context),
                child: Text(
                  _selected,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(4),
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
                size: 35,
              ),
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(bottom: 1),
              onPressed: () => showModal(context),
            ),
          )
        ],
      ),
    );
  }

//*****************************************SHOW MODAL*****************************************//

  void showModal(context) {
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
                    scrollController: FixedExtentScrollController(initialItem: 5),
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
                        _selected = items[selectitem];
                        print(_selected);
                      });
                    },
                  ),
                ),
              ],
            ),
            // Scaffold(
            //   appBar: AppBar(
            //     centerTitle: true,
            //     backgroundColor: Color(0xffd0d5da),
            //     automaticallyImplyLeading: false,
            //     bottomOpacity: 0,
            //     elevation: 0,
            //     title: FlatButton(
            //       textColor: Colors.white,
            //       onPressed: () {
            //         Navigator.of(context).pop();
            //       },
            //       child: Text(
            //         "Done",
            //         style: TextStyle(
            //           fontSize: 20,
            //           color: Colors.blueAccent,
            //         ),
            //       ),
            //       shape: CircleBorder(
            //           side: BorderSide(
            //         color: Colors.transparent,
            //       )),
            //     ),
            //   ),
            //   body: CupertinoPicker(
            //     magnification: 1.5,
            //     diameterRatio: 100.0,
            //     scrollController: FixedExtentScrollController(initialItem: 5),
            //     backgroundColor: Color(0xffd0d5da),
            //     children: List<Widget>.generate(
            //       items.length,
            //       (index) => Center(
            //         child: Text(
            //           items[index],
            //           style: TextStyle(color: Colors.black),
            //         ),
            //       ),
            //     ),
            //     itemExtent: 50, //height of each item
            //     looping: false,
            //     onSelectedItemChanged: (int index) {
            //       setState(() {
            //         selectitem = index;
            //         _selected = items[selectitem];
            //         print(_selected);
            //       });
            //     },
            //   ),
            // ),
          );
        });
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
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
      color: Colors.white.withOpacity(0.08),
      child: Text(
        childtext,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      onPressed: onpress,
    );
  }
}

//         Container(
//           height: 300,
//           child: ListView.separated(
//               itemCount: _items.length,
//               separatorBuilder: (context, int) {
//                 return Divider(
//                   height: 30,
//                   thickness: 2,
//                   color: Colors.black.withOpacity(0.5),
//                 );
//               },
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                     child: Center(
//                       child: Text(
//                         _items[index],
//                         style: TextStyle(
//                             fontSize: 18, color: Colors.black),
//                       ),
//                     ),
//                     onTap: () {
//                       setState(() {
//                         _selected = _items[index];
//                       });
//                     });
//               }),
//

// int selected_item = 0;

// Widget _buildItemPicker(context) {
//   return CupertinoPicker(
//     itemExtent: 10.0,
//     onSelectedItemChanged: (index) {
//       setState(() {
//         selected_item = index;
//       });
//     },
//     children: List<Widget>.generate(
//       items.length,
//       (index) => Center(
//         child: Text(
//           items[index],
//         ),
//       ),
//     ),
//   );
// }

// return Container(
//   color: Color(0xFF737373),
//   height: 280,
//   child: Container(
//     decoration: BoxDecoration(
//       color: Colors.blueGrey[100],
//       borderRadius: BorderRadius.only(
//         topLeft: const Radius.circular(10),
//         topRight: const Radius.circular(10),
//       ),
//     ),
//     child: Column(
//       children: <Widget>[
//         Container(
//           color: Colors.white,
//           child: Align(
//             alignment: Alignment.topRight,
//             child: FlatButton(
//               child: Text(
//                 'Done',
//                 style:
//                     TextStyle(color: Colors.blueAccent, fontSize: 20),
//               ),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ),
//         ),
//       ],
//     ),
//   ),
// );

// appBar: AppBar(
//   title: Text(
//     "CupertinoPicker",
//     textAlign: TextAlign.justify,
//   ),
//   backgroundColor: Colors.teal,
//   actions: <Widget>[
//     IconButton(
//       icon: Icon(Icons.send),
//       onPressed: () {},
//     )
//   ],
// ),

// return Container(
//   height: 280,
//   alignment: Alignment.center,
//   color: Color(0xffd0d5da),
//   child: Column(
//     children: <Widget>[
//       Container(
//         color: Colors.white,
//         height: 40,
//         child: Align(
//           alignment: Alignment.topRight,
//           child: FlatButton(
//             child: Text(
//               'Done',
//               style:
//                   TextStyle(color: Colors.blueAccent, fontSize: 20),
//             ),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ),
//       ),
//       SizedBox(
//         height: 20,
//       ),
//       Container(
//         alignment: Alignment.center,
//         color: Colors.blueGrey[100],
//         child: CupertinoPicker(
//           magnification: 1.5,
//           backgroundColor: Colors.blueGrey,
//           children: <Widget>[
//             Text(
//               "TextWidget",
//               style: TextStyle(color: Colors.white, fontSize: 20),
//             ),
//             MaterialButton(
//               onPressed: () {},
//               child: Text(
//                 "Button Widget",
//                 style: TextStyle(color: Colors.white),
//               ),
//               color: Colors.redAccent,
//             ),
//             IconButton(
//               icon: Icon(Icons.home),
//               color: Colors.white,
//               iconSize: 40,
//               onPressed: () {},
//             )
//           ],
//           itemExtent: 50, //height of each item
//           looping: true,
//           onSelectedItemChanged: (int index) {
//             selectitem = index;
//           },
//         ),
//       ),
//     ],
//   ),
// );

// shape: RoundedRectangleBorder(
//   borderRadius: BorderRadius.circular(16),
// ),
//backgroundColor: Colors.white,
