import 'package:cloud_firestore/cloud_firestore.dart';

class Operation {
  final String op_id;
  final String date;
  final String location;
  final List<String> validation_results;

  Operation({this.op_id, this.date, this.location, this.validation_results});
}