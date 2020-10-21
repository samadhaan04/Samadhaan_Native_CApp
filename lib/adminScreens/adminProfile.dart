import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faridabad/adminScreens/ComplaintScreen.dart';
import 'package:faridabad/adminScreens/departments.dart';
import 'package:faridabad/providers/auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

// void main() {
//   runApp(User());
// }

class AdminProfile extends StatefulWidget {
  static const routename = '/adminProfile';
  @override
  _AdminProfileState createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  var user;
  var topic;
  var dataTopic;
  var workCity, workState;
  SharedPreferences pref;
  final _firestore = Firestore.instance;
  final fbm = FirebaseMessaging();
  bool isOnce = true;
  @override
  void initState() {
    super.initState();
    _firestore.document('DepartmentNames/topic').get().then((value) {
      dataTopic = value.data['topic'];
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (isOnce) {
      pref = await SharedPreferences.getInstance();
      user = ModalRoute.of(context).settings.arguments;
      setState(() {
        user = pref.getString("currentUser");
        workCity = pref.getString('workCity');
        workState = pref.getString('workState');
        print('work $workCity $workState');
        isOnce = false;
      });
    }
  }

  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.001,
                  2,
                  MediaQuery.of(context).size.width * 0.85,
                  5,
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  iconSize: 30,
                  color: Colors.blue,
                  onPressed: () => user == "Admin"
                      ? Navigator.of(context)
                          .pushReplacementNamed(InputData.routeName)
                      : Navigator.of(context).pushReplacementNamed(
                          ComplaintScreen.routeName,
                          arguments: user),
                ),
              ),
              CircleAvatar(
                radius: 100.0,
                backgroundColor: Colors.grey,
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                user,
                style: TextStyle(
                    fontSize: 30.0,
                    color: Theme.of(context).textTheme.bodyText1.color,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    isSwitched ? 'Dark Mode' : 'Light Mode',
                    style: TextStyle(
                        fontSize: 22.0,
                        color: Theme.of(context).textTheme.bodyText1.color,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Transform.scale(
                    scale: 1.2,
                    child: Switch(
                      activeColor: Colors.white,
                      inactiveThumbColor: Colors.grey,
                      inactiveTrackColor: Colors.white,
                      activeTrackColor: Colors.black87,
                      value:
                          Provider.of<AppStateNotifier>(context, listen: false)
                              .isDarkMode,
                      onChanged: (boolValue) {
                        setState(() {
                          isSwitched = !isSwitched;
                          Provider.of<AppStateNotifier>(context, listen: false)
                              .updateTheme(boolValue);
                        });
                      },
                    ),
                  ),
                ],
              ),
              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: Padding(
              //     padding: const EdgeInsets.only(top: 20.0, left: 22),
              //     child: GestureDetector(
              //       child: Text(
              //         'Change Password',
              //         style: TextStyle(
              //             fontSize: 22.0,
              //             color: Theme.of(context).textTheme.bodyText1.color,
              //             fontWeight: FontWeight.w400),
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 50,
              ),
              FlatButton(
                onPressed: () async {
                  final signoutResult = await Auth().signOut();
                  if (signoutResult) {
                    if (user == "Admin") {
                      topic = 'admin';
                    } else {
                      topic = dataTopic[user];
                    }
                    topic = workCity + workState + topic;
                    print('unsubscribing from $topic');
                    fbm.unsubscribeFromTopic(topic);
                    Navigator.of(context).pushReplacementNamed(MyApp.routeName);
                  }
                },
                child: Text(
                  'Logout',
                  style: TextStyle(
                      fontSize: 22.0,
                      color: Theme.of(context).textTheme.bodyText1.color,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
