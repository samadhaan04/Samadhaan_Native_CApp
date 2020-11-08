import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridabad/adminScreens/ComplaintScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListOfDepartments extends StatefulWidget {
  const ListOfDepartments({Key key}) : super(key: key);

  @override
  _ListOfDepartmentsState createState() => _ListOfDepartmentsState();
}

class _ListOfDepartmentsState extends State<ListOfDepartments> {
  Firestore databaseReference;
  List listOfDepartments = [];
  bool loading = false, isOnce = true;
  var workCity, workState;

  int solved, totalForCity;

  @override
  void initState() {
    databaseReference = Firestore.instance;
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (isOnce) {
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
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: databaseReference
          .collection('States/$workState/$workCity')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Map> listOfDepartments = [];
        if (snapshot.hasData) {
          snapshot.data.documents.forEach((val) {
            if (val.documentID.toString() != 'data') {
              print(val.documentID.toString());
              listOfDepartments.add({
                val.documentID.toString(): [val['p'], val['pending']]
              });
            } else {
              solved = val['solved'];
              totalForCity = val['total'];
            }
          });
          return Container(
            child: listOfDepartments.length == 0
                ? Center(
                    child: Text(
                      'No Complaints yet!!',
                      style: TextStyle(color: Colors.white, fontSize: 21),
                    ),
                  )
                : ListView.builder(
                    key: GlobalKey(),
                    itemCount: listOfDepartments.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.fromLTRB(6, 4, 12, 5),
                        decoration: BoxDecoration(
                          // color: Colors.red,
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Badge(
                          badgeColor: Colors.red.withOpacity(0.55),
                          badgeContent: Text(
                            listOfDepartments[index].values.first[1].toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          alignment: Alignment.centerRight,
                          animationType: BadgeAnimationType.scale,
                          animationDuration: Duration(seconds: 1),
                          child: Card(
                            color: Theme.of(context).disabledColor,
                            //Color(0xFF0A0E21),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).disabledColor,
                                // Color(0xff211E2B),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      ComplaintScreen.routeName,
                                      arguments: listOfDepartments[index]
                                          .keys
                                          .single
                                          .toString());
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      fit: FlexFit.loose,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color:
                                              Theme.of(context).disabledColor,
                                          // color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 40, horizontal: 15),
                                        child: FittedBox(
                                          fit: BoxFit.fitWidth,
                                          child: Text(
                                            listOfDepartments[index]
                                                .keys
                                                .single
                                                .toString(),
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1
                                                  .color,
                                              // fontWeight: FontWeight.bold,
                                              fontFamily: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1
                                                  .fontFamily,
                                              fontSize: 22,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 40, horizontal: 5),
                                      child: FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Text(
                                          // '1     ',
                                          listOfDepartments[index]
                                                  .values
                                                  .first[0]
                                                  .toString() +
                                              "    ",
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                .color,
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            fontFamily: Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                .fontFamily,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
