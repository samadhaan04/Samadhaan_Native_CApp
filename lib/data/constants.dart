import 'package:flutter/material.dart';

List<String> depts = [
  "None",
  "Animal Husbandry",
  "BDPO",
  "Civil Hospital",
  "DHBVN(Urban)",
  "DHBVN(Rural)",
  "Distt. Town planner",
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

Map<String, String> emailValue = {
  'animal@samadhaan.com': 'Animal Husbandry',
  'bdpo@samadhaan.com': 'BDPO',
  'civilh@samadhaan.com': 'Civil Hospital',
  'dhbvnu@samadhaan.com': 'DHBVN(Urban)',
  'dhbvnr@samadhaan.com': 'DHBVN(Rural)',
  'dtownPlanner@samadhaan.com': 'Distt. Town planner',
  'elementaryedu@samadhaan.com': 'Education(Elementary)',
  'higheredu@samadhaan.com': 'Education(Higher)',
  'firedepartment@samadhaan.com': 'Fire Department',
  'hvpnl@samadhaan.com': 'HVPNL',
  'irrigation@samadhaan.com': "Irrigation",
  'nagarparishad@samadhaan.com': "Nagar Parishad",
  'pwd@samadhaan.com': "PWD",
  'publicwater@samadhaan.com': "PUBLIC HEALTH(Water)",
  'publicsewage@samadhaan.com': "Public health(Sewage)",
  'publicrenywell@samadhaan.com': "Public health (Reny Well)",
  'socialwelfare@samadhaan.com': "Social Welfare",
  'tehsil@samadhaan.com': "Tehsil",
  'rishi@rishi.com' : 'admin'
};

List<String> getStateList() {
  List<String> wards = [];
  wards.add("None");
  wards.add("Haryana");
  wards.add("Delhi");
  return wards;
}

List<String> getcities(state) {
  if (state == "Haryana") {
    var constituencies = ["None", "Faridabad", "Gurgaon", "Palwal"];
    return constituencies;
  }
  if (state == "Delhi") {
    var constituencies = ["None", "Rkpuram"];
    return constituencies;
  } else {
    var constituencies = [
      "None",
    ];
    return constituencies;
  }
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
