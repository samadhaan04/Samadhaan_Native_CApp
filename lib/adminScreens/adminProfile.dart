import 'package:faridabad/adminScreens/departments.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: <Widget>[
          Row(
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
                  onPressed: () => Navigator.of(context)
                      .pushReplacementNamed(InputData.routeName),
                ),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                radius: 100.0,
                backgroundColor: Colors.grey,
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                'Deepak Mangla',
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
                        fontSize: 30.0,
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
              SizedBox(
                height: 50,
              ),
              FlatButton(
                onPressed: () {},
                child: Text(
                  'Logout',
                  style: TextStyle(
                      fontSize: 30.0,
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
