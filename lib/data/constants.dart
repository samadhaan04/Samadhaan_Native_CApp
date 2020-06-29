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

List<String> getWardsList() {
  List<String> wards = [];
  wards.add("None");
  for (int i = 1; i <= 31; i++) {
    wards.add(i.toString());
  }
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
  'prefer not to say',
];

var villages = [
  "None",
  "Aatar Chahta",
  "Aatva",
  "Aaya Nagar",
  "Acheja",
  "Ajijabad",
  "Akbarpur Dakor",
  "Allika",
  "Amroli",
  "Asaavta",
  "Atoha",
  "Baadka",
  "Baata",
  "Badoli",
  "Bagpur Kala",
  "Balayi",
  "Bamariyaka",
  "Bambu Nagla",
  "Behrampur",
  "Bela",
  "Bharatgadh",
  "Bhavana",
  "Bholdha",
  "Bhued",
  "Bilochpur",
  "Chajju Nagar",
  "Chandhut",
  "Chavvan Ka Nangla",
  "Chirwadi",
  "Dhatir",
  "Dostpur",
  "Farizanpur Khelda",
  "Fatsko Nagar",
  "Ghodi",
  "Ghughera",
  "Gundvas",
  "Gurwadi",
  "Hafzabad (Surjan Nagla)",
  "Hidayatpur",
  "Hoshangabad",
  "Hunsapur",
  "Jevabad Khedli",
  "Kakrali",
  "Kamravali",
  "Karimpur",
  "Karna",
  "Kashipur",
  "Kulena",
  "Kusak",
  "Ladiyaka",
  "Lalghad",
  "Lalpur Kadim",
  "Lalwa",
  "Lulwadi",
  "Maksudpur",
  "Mala Singh Farm",
  "Milak Ganniki",
  "Misa",
  "Munirgadi",
  "Mustafabad",
  "Nagal Bhraman",
  "Nagliya Khurd",
  "Nai Nagla",
  "Nandawal",
  "Patli Khurd",
  "Peer Gadi",
  "Pehruka",
  "Pelak",
  "Prhaladpur",
  "Rahimpur",
  "Rajolka",
  "Rampur Khor",
  "Rasulpur",
  "Raydaska",
  "Rundhi",
  "Sehdev Nangla",
  "Shekpur",
  "Sheru ka Nagla",
  "Sihaul",
  "Soldha",
  "Sujwadi",
  "Sultanpur",
  "Sunheri ka Nagla",
  "Tappa",
  "Taraka",
  "Tekri Gujjar",
  "Thantari",
  "Yadupur",
  "Zhuppa",
];
