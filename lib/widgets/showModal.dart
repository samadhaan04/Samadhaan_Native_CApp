import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ShowModalDrop extends StatefulWidget {
  @override
  _ShowModalDropState createState() => _ShowModalDropState();
}

class _ShowModalDropState extends State<ShowModalDrop> {
  String _selected = 'Select Action';
  List<String> items = [
    'Electricity',
    'Education',
    'Agriculture',
    'Animal Husbandry',
    'Forestry',
    'Irrigation',
    'Check',
    'Post',
  ];
  int selectitem = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
      width: 330,
      height: 30,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 70),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: GestureDetector(
                onTap: () => showModal(context),
                child: Text(
                  _selected,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(4),
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
                size: 35,
              ),
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(bottom: 1),
              onPressed: () => showModal(context),
            ),
          )
        ],
      ),
    );
  }

//*****************************************SHOW MODAL*****************************************//

  void showModal(context) {
    showModalBottomSheet(
        isScrollControlled: false,
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return Container(
            height: 300,
            child: Column(
              children: [
                Container(
                  child: FlatButton(
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Done",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blueAccent,
                      ),
                    ),
                    shape: CircleBorder(
                        side: BorderSide(
                      color: Colors.transparent,
                    )),
                  ),
                ),
                Expanded(
                  child: CupertinoPicker(
                    magnification: 1.5,
                    diameterRatio: 100.0,
                    scrollController:
                        FixedExtentScrollController(initialItem: 5),
                    backgroundColor: Color(0xffd0d5da),
                    children: List<Widget>.generate(
                      items.length,
                      (index) => Center(
                        child: Text(
                          items[index],
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    itemExtent: 50, //height of each item
                    looping: false,
                    onSelectedItemChanged: (int index) {
                      setState(() {
                        selectitem = index;
                        _selected = items[selectitem];
                        print(_selected);
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}
