import 'package:faridabad/clientScreens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:samadhan/screens/home.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomBottomSheet extends StatelessWidget {
  final String title;
  final String refNum;
  final PersistentBottomSheetController controller;
  CustomBottomSheet({this.refNum, this.title, this.controller});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 2.0)),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  heightFactor: 1,
                  alignment: Alignment.topRight,
                  child: IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.black,
                        size: 35,
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => HomeScreen()));
                      }),
                ),
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 46),
                ),
                SizedBox(
                  height: 15,
                ),
                Hero(
                  tag: '',
                  child: Icon(
                    Icons.check_circle_outline,
                    size: 170,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Hero(
                  tag: "1",
                  child: Text(
                    "Tracking Number:",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 25),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  refNum,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ).text.xl2.make(),
                Text(
                  '*Note down the tracking ID or take Screenshot',
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget bottomSheet(String title, String refNum, BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return (null);
    },
  );
}
