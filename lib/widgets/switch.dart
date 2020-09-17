// library lite_rolling_switch;

import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math';

/// Customable and attractive Switch button.
/// Currently, you can't change the widget
/// width and height properties.
///
/// As well as the classical Switch Widget
/// from flutter material, the following
/// arguments are required:
///
/// * [value] determines whether this switch is on or off.
/// * [onChanged] is called when the user toggles the switch on or off.
///
/// If you don't set these arguments you would
/// experiment errors related to animationController
/// states or any other undesirable behavior, please
/// don't forget to set them.
///
class RollingSwitch extends StatefulWidget {
  @required
  final bool value;
  final Gradient myGradient;
  @required
  final Function(bool) onChanged;
  final String textOff;
  final String textOn;
  final Color colorOn;
  final Color colorOff;
  final double textSize;
  final Duration animationDuration;
  final IconData iconOn;
  final IconData iconOff;
  final Function onTap;
  final Function onDoubleTap;
  final Function onSwipe;
  final double pad;

  RollingSwitch({
    this.value,
    this.myGradient,
    this.textOff = "Off",
    this.textOn = "On",
    this.textSize = 14.0,
    this.colorOn = Colors.green,
    this.colorOff = Colors.red,
    this.iconOff = Icons.flag,
    this.iconOn = Icons.check,
    this.animationDuration = const Duration(milliseconds: 600),
    this.onTap,
    this.onDoubleTap,
    this.onSwipe,
    this.onChanged,
    this.pad,
  });

  @override
  _RollingSwitchState createState() => _RollingSwitchState();
}

class _RollingSwitchState extends State<RollingSwitch>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  double value = 0.0;

  bool turnState;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this,
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: widget.animationDuration);
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    animationController.addListener(() {
      setState(() {
        value = animation.value;
      });
    });
    // setState(() {
    turnState = widget.value;
    print('t $turnState');
    _determine();
    //  if(turnState)
    //  {
    //    animationController.forward();
    //  }
    //  else
    //  {
    //    animationController.reverse();
    //  }
    // _action();
    // });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.value) {
      if (turnState) turnState = false;
      animationController.reverse();
    }
    Color transitionColor = Color.lerp(widget.colorOff, widget.colorOn, value);

    return GestureDetector(
      onDoubleTap: () {
        _action();
        if (widget.onDoubleTap != null) widget.onDoubleTap();
      },
      onTap: () {
        _action();
        if (widget.onTap != null) widget.onTap();
      },
      onPanEnd: (details) {
        _action();
        if (widget.onSwipe != null) widget.onSwipe();
        //widget.onSwipe();
      },
      child: Container(
        padding: EdgeInsets.all(5),
        width: 130,
        decoration: BoxDecoration(
            color: transitionColor, borderRadius: BorderRadius.circular(50)),
        child: Stack(
          children: <Widget>[
            Transform.translate(
              offset: Offset(10 * value, 0), //original
              child: Opacity(
                opacity: (1 - value).clamp(0.0, 1.0),
                child: Container(
                  padding: EdgeInsets.only(
                    right: widget.pad,
                  ),
                  alignment: Alignment.centerRight,
                  height: 40,
                  child: Text(
                    widget.textOff,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1.color,
                        fontWeight: FontWeight.bold,
                        fontSize: widget.textSize),
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(10 * (1 - value), 0), //original
              child: Opacity(
                opacity: value.clamp(0.0, 1.0),
                child: Container(
                  padding: EdgeInsets.only(/*top: 10,*/ left: 5),
                  alignment: Alignment.centerLeft,
                  height: 40,
                  child: Text(
                    widget.textOn,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1.color,
                        fontWeight: FontWeight.bold,
                        fontSize: widget.textSize),
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(80 * value, 0),
              child: Transform.rotate(
                  angle: lerpDouble(0, 2 * pi, value),
                  child: turnState
                      ? Container(
                          height: 40,
                          width: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              // gradient: widget.myGradient,
                              color: Colors.white),
                          // child: Stack(
                          //   children: <Widget>[
                          //     // Center(
                          //     //   child: Opacity(
                          //     //     opacity: (1 - value).clamp(0.0, 1.0),
                          //     //     child: Icon(
                          //     //       widget.iconOff,
                          //     //       size: 25,
                          //     //       color: transitionColor,
                          //     //     ),
                          //     //   ),
                          //     // ),
                          //     // Center(
                          //     //     child: Opacity(
                          //     //         opacity: value.clamp(0.0, 1.0),
                          //     //         child: Icon(
                          //     //           widget.iconOn,
                          //     //           size: 21,
                          //     //           color: transitionColor,
                          //     //         ))),
                          //   ],
                          // ),
                        )
                      : Container(
                          height: 40,
                          width: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: widget.myGradient),
                          // child: Stack(
                          //   children: <Widget>[
                          //     // Center(
                          //     //   child: Opacity(
                          //     //     opacity: (1 - value).clamp(0.0, 1.0),
                          //     //     child: Icon(
                          //     //       widget.iconOff,
                          //     //       size: 25,
                          //     //       color: transitionColor,
                          //     //     ),
                          //     //   ),
                          //     // ),
                          //     // Center(
                          //     //     child: Opacity(
                          //     //         opacity: value.clamp(0.0, 1.0),
                          //     //         child: Icon(
                          //     //           widget.iconOn,
                          //     //           size: 21,
                          //     //           color: transitionColor,
                          //     //         ))),
                          //   ],
                          // ),
                        )),
            )
          ],
        ),
      ),
    );
  }

  _action() {
    _determine(changeState: true);
  }

  _determine({bool changeState = false}) {
    setState(() {
      if (changeState) turnState = !turnState;
      (turnState)
          ? animationController.forward()
          : animationController.reverse();
      widget.onChanged(turnState);
    });
  }
}
