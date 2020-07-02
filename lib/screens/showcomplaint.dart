import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ShowComplaint extends StatefulWidget {
  static const routeName = '/show-complaint';
  @override
  _ShowComplaintState createState() => _ShowComplaintState();
}

class _ShowComplaintState extends State<ShowComplaint> {
  var rating = 3.0;
  @override
  Widget build(BuildContext context) {
    final complaintId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 35,
          bottom: 15,
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.lime[200],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Complaint',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Container(
                      alignment: Alignment(1, 1),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.22,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                        ),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              8,
                            ),
                          ),
                          textColor: Colors.limeAccent[700],
                          child: Text(
                            'Attached Image',
                            style: TextStyle(fontSize: 12.0),
                            textAlign: TextAlign.center,
                          ),
                          color: Colors.black,
                          elevation: 10.0,
                          onPressed: () {
                            return _showBottomSheet(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.tealAccent[200],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Hello',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      // decoration: BoxDecoration(
                      //   border: Border.all(
                      //     color: Colors.black,
                      //   ),
                      //   borderRadius: BorderRadius.circular(
                      //     10.0,
                      //   ),
                      //   shape: BoxShape.rectangle,
                      //   //  color: Colors.orangeAccent,
                      // ),
                    ),
                    Container(
                      alignment: Alignment(1, 1),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.22,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                        ),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              8,
                            ),
                          ),
                          textColor: Colors.limeAccent[700],
                          child: Text(
                            'Attached Image',
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          color: Colors.black,
                          elevation: 10.0,
                          onPressed: () {
                            return _showBottomSheet(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                    ),
                    textColor: Colors.blueGrey[200],
                    child: Text(
                      'FEEDBACK',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    color: Colors.pink[900],
                    elevation: 10.0,
                    onPressed: () {
                      return _showBottomSheet(context);
                    },
                  ),
                  // SizedBox(
                  //   height: 5.0,
                  // ),
                  Expanded(
                    child: Center(
                      child: SmoothStarRating(
                          allowHalfRating: false,
                          onRated: (v) {},
                          starCount: 5,
                          rating: rating,
                          size: 50.0,
                          isReadOnly: false,
                          // filledIconData: Icons.blur_off,
                          halfFilledIconData: Icons.blur_on,
                          color: Colors.blue,
                          borderColor: Colors.blueAccent,
                          spacing: 3.0),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

//  final Widget image ;
  void _showBottomSheet(BuildContext cotx) {
    int x = 1;
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: cotx,
        builder: (bctx) {
          return Container(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            height: MediaQuery.of(context).size.height * 0.75,
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(25.0),
                topRight: const Radius.circular(25.0),
              ),
            ),
            child: GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, top: 20.0, right: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black54,
                          ),
                        ),
                        child: x == 1 ? Text('Image') : Text("Add Image"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
