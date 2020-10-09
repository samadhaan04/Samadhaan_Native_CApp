import 'package:faridabad/adminScreens/complaintDescriptionCard.dart';
import 'package:flutter/material.dart';

class Coloured extends StatefulWidget {
  const Coloured({Key key}) : super(key: key);

  @override
  _ColouredState createState() => _ColouredState();
}

class _ColouredState extends State<Coloured> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      height: MediaQuery.of(context).size.height / 6.5,
      margin: EdgeInsets.symmetric(
        vertical: 1,
        horizontal: 10,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: ReusableCardComplaint(
              colour: Theme.of(context).backgroundColor,
              // colour2: Color(0xff85EB29),
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Switch(
                  //   activeColor: Colors.white,
                  //   inactiveThumbColor: Colors.black,
                  //   inactiveTrackColor: Colors.white,
                  //   activeTrackColor: Colors.black87,
                  //   value: Provider.of<AppStateNotifier>(context, listen: false)
                  //       .isDarkMode,
                  //   onChanged: (boolValue) {
                  //     setState(() {
                  //       Provider.of<AppStateNotifier>(context, listen: false)
                  //           .updateTheme(boolValue);
                  //     });
                  //   },
                  // ),
                  Block('12/35', 2.0, 25.0,
                      Theme.of(context).textTheme.bodyText1.color),
                  Block('Solved', 2.0, 25.0,
                      Theme.of(context).textTheme.bodyText1.color),
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
                    colour: Theme.of(context).accentColor,
                    // colour2: Color(0xffFE7325),
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Block('2/5', 2.0, 22.0,
                            Theme.of(context).textTheme.bodyText1.color),
                        Block('Per Day', 1.5, 17.0,
                            Theme.of(context).textTheme.bodyText1.color),
                      ],
                    ),
                  ),
                ),
                // Expanded(
                //   child: ReusableCardComplaint(
                //     colour: Theme.of(context).accentColor,
                //     // colour2: Color(0xff34AFFF),
                //     cardChild: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: <Widget>[
                //         Block('4.5', 2.0, 20.0,
                //             Theme.of(context).textTheme.bodyText1.color),
                //         Block('User Rating', 2.0, 18.0,
                //             Theme.of(context).textTheme.bodyText1.color),
                //       ],
                //     ),
                //   ),
                // ),
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
  final Color colour;

  Block(this.text, this.spacing, this.sizeFont, this.colour);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: colour,
          letterSpacing: spacing,
          fontSize: sizeFont,
          fontFamily: 'Lato',
          fontWeight: FontWeight.bold),
    );
  }
}
