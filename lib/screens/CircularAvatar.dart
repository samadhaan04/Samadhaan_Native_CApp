import 'package:flutter/material.dart';
import 'complaint.dart';

class CircularAvatar extends StatelessWidget {
  final ComplaintStatus status;

  CircularAvatar({@required this.status});

  @override
  Widget build(BuildContext context) {
    if (status == ComplaintStatus.Ongoing)
      return Container(
        width: 45,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Color(0xfff4b601),
              Color(0xffffee77),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      );
    else if (status == ComplaintStatus.New)
      return Container(
        width: 45,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Color(0xff3d84fa),
              Color(0xff34afff),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      );
    else if (status == ComplaintStatus.Done)
      return Container(
        width: 45,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Color(0xff51b328),
              Color(0xff85eb29),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      );
    else if (status == ComplaintStatus.Transfer)
      return Container(
        width: 45,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Color(0xffff4A2B),
              Color(0xffFE7325),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      );
    return null;
  }
}
