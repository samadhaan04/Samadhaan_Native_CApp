import 'package:faridabad/main.dart';
import 'package:faridabad/providers/auth.dart';
import 'package:faridabad/adminScreens/statsBoxes.dart';
import 'package:faridabad/loginScreen.dart';
import 'package:faridabad/adminScreens/listOfDepartments.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'adminProfile.dart';

class InputData extends StatefulWidget {
  static const routeName = '/input-data';

  @override
  _InputDataState createState() => _InputDataState();
}

class _InputDataState extends State<InputData> {
  String dropdownValue = '';

  // var _items = ['Profile'];

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
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          iconTheme: IconThemeData(color: Colors.grey),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            //   Container(
            //     margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
            //     child: DropdownButton(
            //       underline: Container(),
            //       onChanged: (value) async {
            //         setState(() {
            //           dropdownValue = value;
            //         });
            //         // if (dropdownValue == 'Logout') {
            //         //   final signoutResult = await Auth().signOut();
            //         //   // print('sign out');
            //         //   if (signoutResult) {
            //         //     Navigator.of(context)
            //         //         .pushReplacementNamed(MyApp.routeName);
            //         //   }
            //         // }
            //         if (dropdownValue == 'Profile') {
            //           Navigator.of(context)
            //               .pushReplacementNamed(AdminProfile.routename);
            //         }
            //       },
            //       icon: Icon(
            //         Icons.account_circle,
            //         size: 35,
            //       ),
            //       items: _items.map((e) {
            //         return DropdownMenuItem(
            //           child: Text(e),
            //           value: e,
            //         );
            //       }).toList(),
            //     ),
            //   ),
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () => Navigator.of(context)
                  .pushReplacementNamed(AdminProfile.routename),
              iconSize: 35,
              color: Colors.grey[600],
            )
          ],
          title: Text(
            'Palwal,Haryana',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Coloured(),
            SizedBox(
              height: 10,
            ),
            Expanded(child: ListOfDepartments()),
          ],
        ),
      ),
    );
  }
}
