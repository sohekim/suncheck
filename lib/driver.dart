import 'package:flutter/material.dart';
import 'package:suncheck/util/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.initDatabase();
  print(await DatabaseHelper.records());

  // var one = Record(energy: 20, date: DateTime.now().subtract(Duration(days: 1)));
  // var two = Record(energy: 60, date: DateTime.now().subtract(Duration(days: 2)));
  // var three = Record(energy: 15, date: DateTime.now().subtract(Duration(days: 3)));
  // var four = Record(energy: 30, date: DateTime.now().subtract(Duration(days: 4)));
  // var five = Record(energy: 40, date: DateTime.now().subtract(Duration(days: 5)));
  // var six = Record(energy: 10, date: DateTime.now().subtract(Duration(days: 6)));
  // var seven = Record(energy: 31, date: DateTime.now().subtract(Duration(days: 7)));
  // var eight = Record(energy: 45, date: DateTime.now().subtract(Duration(days: 8)));

  // await DatabaseHelper.insertRecord(one);
  // await DatabaseHelper.insertRecord(two);
  // await DatabaseHelper.insertRecord(three);
  // await DatabaseHelper.insertRecord(four);
  // await DatabaseHelper.insertRecord(five);
  // await DatabaseHelper.insertRecord(six);
  // await DatabaseHelper.insertRecord(seven);
  // await DatabaseHelper.insertRecord(eight);
}
