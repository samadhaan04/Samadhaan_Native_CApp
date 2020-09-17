import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridabad/adminScreens/ComplaintScreen.dart';
import 'package:flutter/material.dart';

class ListOfDepartments extends StatefulWidget {
  const ListOfDepartments({Key key}) : super(key: key);

  @override
  _ListOfDepartmentsState createState() => _ListOfDepartmentsState();
}

class _ListOfDepartmentsState extends State<ListOfDepartments> {
  Firestore databaseReference;
  List listOfDepartments = [];
  bool loading = false;

  @override
  void initState() {
    databaseReference = Firestore.instance;
    // fetchDepartments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: databaseReference.collection('States/Haryana/Palwal').snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Map> listOfDepartments = [];
        if (snapshot.hasData) {
          snapshot.data.documents.forEach((val) {
            print(val.documentID.toString());
            listOfDepartments.add({val.documentID.toString(): val['p']});
          });
          return Container(
            child: ListView.builder(
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
                      '3',
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).disabledColor,
                                  // color: Colors.green,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 40, horizontal: 15),
                                child: Text(
                                  // dept[index].department,
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
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 40, horizontal: 5),
                                child: Text(
                                  // '1     ',
                                  listOfDepartments[index]
                                          .values
                                          .single
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
