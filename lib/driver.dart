import 'package:flutter/material.dart';
import 'package:suncheck/model/record.dart';
import 'package:suncheck/util/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.initDatabase();
  print(await DatabaseHelper.records());

  var one = Record(energy: 20, date: DateTime.now().subtract(Duration(days: 1)), location: 'Paris, France');
  var two = Record(energy: 60, date: DateTime.now().subtract(Duration(days: 2)), location: 'Seoul, Korea');
  var three = Record(energy: 15, date: DateTime.now().subtract(Duration(days: 3)), location: 'Boston, US');
  var four = Record(energy: 30, date: DateTime.now().subtract(Duration(days: 4)), location: 'Seoul, Korea');
  var five = Record(energy: 40, date: DateTime.now().subtract(Duration(days: 5)), location: 'Suwon, Korea');
  var six = Record(energy: 10, date: DateTime.now().subtract(Duration(days: 6)), location: 'Busan, Korea');
  var seven = Record(energy: 31, date: DateTime.now().subtract(Duration(days: 7)), location: 'Daegu, Korea');
  var eight = Record(energy: 45, date: DateTime.now().subtract(Duration(days: 8)), location: 'Seoul, Korea');

  await DatabaseHelper.insertRecord(one);
  await DatabaseHelper.insertRecord(two);
  await DatabaseHelper.insertRecord(three);
  await DatabaseHelper.insertRecord(four);
  await DatabaseHelper.insertRecord(five);
  await DatabaseHelper.insertRecord(six);
  await DatabaseHelper.insertRecord(seven);
  await DatabaseHelper.insertRecord(eight);
}
