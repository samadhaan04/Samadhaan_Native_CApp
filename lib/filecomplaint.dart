import 'package:faridabad/widgets/modalSheet.dart';
import 'package:flutter/material.dart';

class FileComplaint extends StatelessWidget {
  static const routeName = 'file-complaint';
  // list of departments

  final List<String> _depts = [
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

  // final _selectedDepartment = 'none';
  // Function to show pop-up sheet
  void showModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ModalSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'File ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                          ),
                        ),
                        Text(
                          'Complaint',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 50,
                              color: Colors.teal[200]),
                        ),
                      ],
                    ),
                  ),
                  // TO BE DONE: Render a custom image from backend
                  SizedBox(
                    height: 200,
                  ),
                  Text(
                    'Samadhaan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Faridabad',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Colors.teal[200],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.assignment,
                          size: 40,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        DropdownButton<String>(
                          hint: Text(
                            'Department',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          items: _depts.map((String dropDownItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownItem,
                              child: Text(dropDownItem),
                            );
                          }).toList(),
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.assignment,
                          size: 40,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: TextField(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: 'Complaint',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  // TO BE DONE: take input image from user
                  // RaisedButton(
                  //   child: Text(
                  //     'Image',
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 20,
                  //     ),
                  //   ),
                  //   onPressed: () {},
                  //   elevation: 5,
                  //   color: Colors.greenAccent,
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(100, 10, 100, 10),
                    child: RaisedButton(
                      padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () => showModalSheet(context),
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
