import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridabad/main2.dart';
import 'package:faridabad/screens/department.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  // void fetchDepartments() async {
  //   setState(() {
  //     loading = true;
  //   });
  //   await databaseReference
  //       .collection('States/Haryana/Palwal')
  //       .getDocuments()
  //       .then((value) {
  //     value.documents.forEach((element) async {
  //       await databaseReference
  //           .collection(
  //               'States/Haryana/Palwal/${element.documentID.toString()}/Complaints')
  //           .getDocuments()
  //           .then((value) {
  //         String name = element.documentID.toString();
  //         Map<String, int> entry = {name: value.documents.length};
  //         listOfDepartments.add(entry);
  //       });
  //       setState(() {

  //       });
  //       // listOfDepartments.;
  //     });
  //   });
  //   setState(() {
  //     loading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: databaseReference.collection('States/Haryana/Palwal').snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<Map> listOfDepartments = [];
        if (snapshot.hasData) {
          snapshot.data.documents.forEach((val) {
            print(val.documentID.toString());
            listOfDepartments.add({val.documentID.toString() : val['p']});
          });
          return Container(
            child: ListView.builder(
              key: GlobalKey(),
              // shrinkWrap: true,
              itemCount: listOfDepartments.length,
              itemBuilder: (context, index) {
                return Container(
                  // color: Colors.green,
                  margin: EdgeInsets.symmetric(
                    vertical: 1,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Badge(
                    badgeColor: Colors.red,
                    badgeContent: Text('3'),
                    alignment: Alignment.centerRight,
                    animationType: BadgeAnimationType.scale,
                    animationDuration: Duration(seconds: 1),
                    child: Card(
                      // margin: EdgeInsets.all(value),
                      color: Color(0xFF0A0E21),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xff211E2B),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(AdminApp.routeName,
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
                                  color: Color(0xff211E2B),
                                  // color: Colors.green,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 50, horizontal: 20),
                                child: Text(
                                  // dept[index].department,
                                  listOfDepartments[index]
                                      .keys
                                      .single
                                      .toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Nunito',
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                              Text(
                                // '1     ',
                                listOfDepartments[index]
                                    .values
                                    .single
                                    .toString() + "    ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
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
        }
        else
        {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
