import 'package:flutter/material.dart';



List<String> getStateList() {
  List<String> wards = [];
  wards.add("None");
  wards.add("Haryana");
  wards.add("Delhi");
  return wards;
}

// List<String> getcities(state) {
//   if (state == "Haryana") {
//     var constituencies = ["None", "Faridabad", "Gurgaon", "Palwal"];
//     return constituencies;
//   }
//   if (state == "Delhi") {
//     var constituencies = ["None", "Rkpuram"];
//     return constituencies;
//   } else {
//     var constituencies = [
//       "None",
//     ];
//     return constituencies;
//   }
// }

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
