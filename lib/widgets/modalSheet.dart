import 'package:flutter/material.dart';

class ModalSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
        Container(
      decoration: BoxDecoration(
          border: Border.all(
        color: Colors.grey,
        width: 3,
      )),
      height: MediaQuery.of(context).size.height / 3,
      padding: EdgeInsets.all(5), 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.close,size: 40,),
            onPressed: () {
              Navigator.of(context).pop();
            },
            alignment: Alignment.topRight,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              'Successfully Submitted',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.check,
              size: 80,
            ),
          ),
        ],
        // TO BE DONE: Render custom designed Ad
      ),
      // ),
    );
  }
}
