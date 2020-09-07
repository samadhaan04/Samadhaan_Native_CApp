import 'package:flutter/material.dart';

enum ComplaintStatus {
  Transfer,
  Ongoing,
  Done,
  New,
}

class Complaint {
  final ComplaintStatus status;
  final String complaint;

  const Complaint({
    @required this.complaint,
    @required this.status,
  });
}
