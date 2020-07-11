import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

List<String> depts = [
  "None",
  "Animal Husbandry",
  "BDPO",
  "Civil Hospital",
  "DHBVN(Urban)",
  "DHBVN(Rural)",
  "Distt. Town planner ",
  "Education(Elementary)",
  "Education(Higher)",
  "Fire Department",
  "HVPNL",
  "Irrigation",
  "Nagar Parishad",
  "PWD",
  "PUBLIC HEALTH(Water)",
  "Public health(Sewage)",
  "Public health (Reny Well)",
  "Social Welfare",
  "Tehsil"
];

List<String> getStateList() {
  List<String> wards = [];
  wards.add("None");
  wards.add("Haryana");
  wards.add("Delhi");
  return wards;
}

var brandText = RichText(
  text: TextSpan(
      text: "Sama",
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 44,
          letterSpacing: 1,
          color: Colors.black),
      children: <TextSpan>[
        TextSpan(
            text: "dhaan",
            style: TextStyle(
                letterSpacing: 1,
                fontSize: 44,
                color: Colors.grey[500],
                fontFamily: "Sans Serif"))
      ]),
);
var complaintText = RichText(
  text: TextSpan(
      text: "File",
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 40,
          letterSpacing: 1,
          color: Colors.black),
      children: <TextSpan>[
        TextSpan(
            text: "Complaint",
            style: TextStyle(
                letterSpacing: 1,
                fontSize: 40,
                color: Colors.grey[500],
                fontFamily: "Sans Serif"))
      ]),
);

var userInfoText = RichText(
  text: TextSpan(
      text: "User",
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 40,
          letterSpacing: 1,
          color: Colors.black),
      children: <TextSpan>[
        TextSpan(
            text: "Information",
            style: TextStyle(
                letterSpacing: 1,
                fontSize: 40,
                color: Colors.grey[500],
                fontFamily: "Sans Serif"))
      ]),
);

var trackText = RichText(
  text: TextSpan(
      text: "Track",
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 40,
          letterSpacing: 1,
          color: Colors.black),
      children: <TextSpan>[
        TextSpan(
            text: "Complaint",
            style: TextStyle(
                letterSpacing: 1,
                fontSize: 40,
                color: Colors.grey[500],
                fontFamily: "Sans Serif"))
      ]),
);

var gender = [
  'male',
  'female',
  'other',
];

var constituencies = [
  "None",
  "Faridabad",
  "Gurgaon",
];

Widget PlatformAlertDialog(BuildContext context, String title, var message,
    Function onPressed, String btnTitle) {
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    title: Text(title),
    content: message,
    actions: <Widget>[
      FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.black,
        textColor: Colors.white,
        onPressed: onPressed,
        child: Text(btnTitle),
      )
    ],
  );
}
