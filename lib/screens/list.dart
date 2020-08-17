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

  var databaseReference;
  List<String> listOfDepartments = [];
  bool loading = false;
  @override
  void initState() {
    databaseReference = Firestore.instance;
    fetchDepartments();
    super.initState();
  }

  void fetchDepartments() async {
    setState(() {
      loading = true;
    });
    await databaseReference
        .collection('States/Haryana/Palwal')
        .getDocuments()
        .then((value) {
      print('yo ${value.documents}');
      value.documents.forEach((element) {
        print(element.documentID.toString());
        listOfDepartments.add(element.documentID.toString());
      });
    });
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
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
                              arguments: listOfDepartments[index]);
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
                                listOfDepartments[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Nunito',
                                  fontSize: 22,
                                ),
                              ),
                            ),
                            Text(
                              '1',
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
          );
  }
}
