import 'package:flutter/material.dart';

class ShowComplaintsNew1 extends StatefulWidget {
  static const routeName = "/yoscjns";
  @override
  _ShowComplaintsNew1State createState() => _ShowComplaintsNew1State();
}

class _ShowComplaintsNew1State extends State<ShowComplaintsNew1> {
  bool expandedDesc = true;
  bool expandedImg = true;
  bool expandedLog = true;
  bool expandedReq = true;
  bool feedback = true;
  bool request = true;
  bool pressed = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff15131E),
      body: Card(
        color: Color(0xff15131E),
        elevation: 10,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 40),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                descExpansion('Lorem ipsum'),
                SizedBox(
                  height: 20,
                ),
                logExpansion(),
                SizedBox(
                  height: 20,
                ),
                imgExpansion(),
                // data['imageURL']),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Actions',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                pressed
                    ? SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.01),
                          width: double.infinity,
                          child: Row(
                            children: <Widget>[
                              buttonFlat(
                                "Feedback",
                                () {
                                  setState(() {
                                    pressed = false;
                                    feedback = false;
                                    request = true;
                                  });
                                },
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              buttonFlat(
                                "Request Transfer",
                                () {
                                  setState(() {
                                    pressed = false;
                                    feedback = true;
                                    request = false;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    : request
                        ? Column(
                            children: <Widget>[
                              textField(
                                'Enter Feedback',
                              ),
                              Center(
                                child: FlatButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Send Feedback',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              )
                            ],
                          )
                        : SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                textField('Enter Request'),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  width: double.infinity,
                                  child: Row(
                                    children: <Widget>[
                                      FlatButton(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 5),
                                        shape: Border.all(color: Colors.white),
                                        child: Text(
                                          "Select Department",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                          softWrap: true,
                                        ),
                                        onPressed: () {},
                                      ),
                                      SizedBox(
                                        width: 14,
                                      ),
                                      FlatButton(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 5),
                                        shape: Border.all(color: Colors.white),
                                        child: Text(
                                          "Request Transfer",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                          softWrap: true,
                                        ),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                SizedBox(
                  height: 15,
                ),
                FlatButton(
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                  shape: Border.all(color: Colors.white),
                  child: Text(
                    "Mark Complete",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
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
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.expand_less,
                      size: 40,
                      color: Colors.white,
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
                      color: Color(0xff211E2B),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15)),
                  padding: EdgeInsets.fromLTRB(25, 20, 25, 40),
                  child: Text(
                    complaint,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
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
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.expand_more,
                  size: 40,
                  color: Colors.white,
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
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.expand_less,
                      size: 40,
                      color: Colors.white,
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
                  // // margin: EdgeInsets.symmetric(vertical: 10),
                  // child: ListView.builder(
                  //   key: GlobalKey(),
                  //   itemCount: images.length,
                  //   scrollDirection: Axis.horizontal,
                  //   itemBuilder: (context, index) {
                  //     return imageBox(images[index]);
                  //   },
                  // ),
                ),
              ),
            ],
          )
        : Row(
            children: <Widget>[
              Text(
                'Images',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.expand_more,
                  size: 40,
                  color: Colors.white,
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
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.expand_less,
                      size: 40,
                      color: Colors.white,
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
                      color: Color(0xff211E2B),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15)),
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 30),
                  child: Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
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
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.expand_more,
                  size: 40,
                  color: Colors.white,
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

  Widget textField(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
        ),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: text,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.5),
          ),
        ),
        maxLines: null,
        style: TextStyle(
          fontSize: 15,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buttonFlat(String childtext, Function pressed) {
    return FlatButton(
      padding: EdgeInsets.all(20),
      shape: Border.all(color: Colors.white),
      child: Text(
        childtext,
        style: TextStyle(
          fontSize: 15,
          color: Colors.white,
        ),
      ),
      onPressed: pressed,
    );
  }
}
