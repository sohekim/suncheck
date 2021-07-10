import 'package:intl/intl.dart';

class Record {
  int id;
  DateTime date;
  int energy;

  Record({int id, DateTime date, int energy}) {
    this.id = id;
    this.date = DateTime.parse(DateFormat('yyyy-MM-dd 00:00:00.000').format(date));
    this.energy = energy;
  }

  // Record({this.id, this.date, this.energy});

  Map<String, dynamic> toMap() {
    return {'id': id, 'date': date.toString(), 'energy': energy};
  }

  @override
  String toString() {
    return 'Record{id: $id, date: $date, energy: $energy}';
  }
}
