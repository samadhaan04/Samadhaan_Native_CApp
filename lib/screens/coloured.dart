import 'package:faridabad/screens/reusable_card.dart';
import 'package:flutter/material.dart';

class Coloured extends StatelessWidget {
  const Coloured({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3.5,
      margin: EdgeInsets.symmetric(
        vertical: 1,
        horizontal: 10,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: ReusableCardComplaint(
              colour: Color(0xff51B328),
              // colour2: Color(0xff85EB29),
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '12 / 35',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        letterSpacing: 2.0,
                        fontSize: 25.0,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Solved',
                    style: TextStyle(
                        letterSpacing: 2.0,
                        fontSize: 25.0,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: ReusableCardComplaint(
                    colour: Color(0xFFFF4A2B),
                    // colour2: Color(0xffFE7325),
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '2/5',
                          style: TextStyle(
                              letterSpacing: 2.0,
                              fontSize: 22.0,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Per Day',
                          style: TextStyle(
                              letterSpacing: 1.5,
                              fontSize: 17.0,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCardComplaint(
                    colour: Color(0xff3D84FA),
                    // colour2: Color(0xff34AFFF),
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '4.5',
                          style: TextStyle(
                              letterSpacing: 2.0,
                              fontSize: 20.0,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'User Rating',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'Lato',
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
