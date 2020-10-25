import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridabad/adminScreens/complaintDescriptionCard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Coloured extends StatefulWidget {
  const Coloured({Key key}) : super(key: key);

  @override
  _ColouredState createState() => _ColouredState();
}

class _ColouredState extends State<Coloured> {
  Firestore databaseReference;
  var workCity;
  var workState;
  var loading = true;
  bool isOnce = true;
  @override
  void initState() {
    databaseReference = Firestore.instance;
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    if (isOnce) {
      final pref = await SharedPreferences.getInstance();
      setState(() {
        loading = true;
      });
      workCity = pref.getString('workCity');
      workState = pref.getString('workState');
      setState(() {
        isOnce = false;
        loading = false;
      });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(child: CircularProgressIndicator())
        : StreamBuilder(
            stream: databaseReference
                .collection('States/$workState/$workCity')
                .document('data')
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data.data);
                if (snapshot.data.data==  null) {
                  return Center(
                    child: Container(),
                  );
                } else {
                  var solved = snapshot.data['solved'];
                  var total = snapshot.data['total'];
                  return Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    height: MediaQuery.of(context).size.height / 6.5,
                    margin: EdgeInsets.symmetric(
                      vertical: 1,
                      horizontal: 10,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: ReusableCardComplaint(
                            colour: Theme.of(context).backgroundColor,
                            // colour2: Color(0xff85EB29),
                            cardChild: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Block(
                                    '$solved/$total',
                                    // 'yo',
                                    2.0,
                                    25.0,
                                    Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .color),
                                Block(
                                    'Solved',
                                    2.0,
                                    25.0,
                                    Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .color),
                              ],
                            ),
                          ),
                        ),
                        // Expanded(
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.stretch,
                        //     children: <Widget>[
                        //       Expanded(
                        //         child: ReusableCardComplaint(
                        //           colour: Theme.of(context).accentColor,
                        //           // colour2: Color(0xffFE7325),
                        //           cardChild: Column(
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             children: <Widget>[
                        //               Block('2/5', 2.0, 22.0,
                        //                   Theme.of(context).textTheme.bodyText1.color),
                        //               Block('Per Day', 1.5, 17.0,
                        //                   Theme.of(context).textTheme.bodyText1.color),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //       // Expanded(
                        //       //   child: ReusableCardComplaint(
                        //       //     colour: Theme.of(context).accentColor,
                        //       //     // colour2: Color(0xff34AFFF),
                        //       //     cardChild: Column(
                        //       //       mainAxisAlignment: MainAxisAlignment.center,
                        //       //       children: <Widget>[
                        //       //         Block('4.5', 2.0, 20.0,
                        //       //             Theme.of(context).textTheme.bodyText1.color),
                        //       //         Block('User Rating', 2.0, 18.0,
                        //       //             Theme.of(context).textTheme.bodyText1.color),
                        //       //       ],
                        //       //     ),
                        //       //   ),
                        //       // ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  );
                }
              } 
              return Center(child: Container(),);
            });
  }
}

class Block extends StatelessWidget {
  final String text;
  final double spacing;
  final double sizeFont;
  final Color colour;

  Block(this.text, this.spacing, this.sizeFont, this.colour);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: colour,
          letterSpacing: spacing,
          fontSize: sizeFont,
          fontFamily: 'Lato',
          fontWeight: FontWeight.bold),
    );
  }
}
