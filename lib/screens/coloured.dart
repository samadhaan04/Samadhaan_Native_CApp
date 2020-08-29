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
                  Block('12/35', 2.0, 25.0),
                  Block('Solved', 2.0, 25.0),
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
                        Block('2/5', 2.0, 22.0),
                        Block('Per Day', 1.5, 17.0),
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
                        Block('4.5', 2.0, 20.0),
                        Block('User Rating', 2.0, 18.0),
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

class Block extends StatelessWidget {
  final String text;
  final double spacing;
  final double sizeFont;

  Block(this.text, this.spacing, this.sizeFont);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          letterSpacing: spacing,
          fontSize: sizeFont,
          fontFamily: 'Lato',
          fontWeight: FontWeight.bold),
    );
  }
}
