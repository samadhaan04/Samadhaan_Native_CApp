import 'package:faridabad/main.dart';
import 'package:faridabad/providers/auth.dart';
import 'package:faridabad/adminScreens/statsBoxes.dart';
import 'package:faridabad/loginScreen.dart';
import 'package:faridabad/adminScreens/listOfDepartments.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'adminProfile.dart';

class InputData extends StatefulWidget {
  static const routeName = '/input-data';

  @override
  _InputDataState createState() => _InputDataState();
}

class _InputDataState extends State<InputData> {
  String dropdownValue = '';
  var workCity;
  var workState;
  SharedPreferences pref;
  final fbm = FirebaseMessaging();
  bool isOnce = true;
  // var _items = ['Profile'];

  @override
  void initState() {
    super.initState();
    fbm.requestNotificationPermissions();
    fbm.configure(
      onLaunch: (message) {
        print('onLaunch');
        print(message);
        return;
      },
      onMessage: (message) {
        print('onMessage');
        print(message);
        return;
      },
      onResume: (message) {
        print('onBackgroundMessage');
        print(message);
        return;
      },
    );
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (isOnce) {
      pref = await SharedPreferences.getInstance();
      workCity = pref.getString('workCity');
      workState = pref.getString('workState');
      print('subscribing to $workState$workCity' + 'admin');
      fbm.subscribeToTopic('$workState$workCity' + 'admin');
      isOnce = false;
      setState(() {});
    }
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit the App'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              FlatButton(
                onPressed: () => SystemNavigator.pop(),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        // appBar: AppBar(
        //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        //   iconTheme: IconThemeData(color: Colors.grey),
        //   automaticallyImplyLeading: false,
        //   actions: <Widget>[

        //   ],
        //   title:
        // ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Text(
                        '$workCity, $workState',
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).textTheme.bodyText1.color,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.account_circle),
                      onPressed: () => Navigator.of(context)
                          .pushNamed(AdminProfile.routename,
                              arguments: "Admin"),
                      iconSize: 35,
                      color: Colors.grey[600],
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Coloured(),
                SizedBox(
                  height: 10,
                ),
                Expanded(child: ListOfDepartments()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
