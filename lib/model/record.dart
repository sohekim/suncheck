import 'package:intl/intl.dart';

class Record {
  int id;
  DateTime date;
  int energy;
  String location;

  Record({int id, DateTime date, int energy, String location}) {
    this.id = id;
    this.date = DateTime.parse(DateFormat('yyyy-MM-dd 00:00:00.000').format(date));
    this.energy = energy;
    this.location = location;
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'date': date.toString(), 'energy': energy, 'location': location};
  }

  @override
  String toString() {
    return 'Record{id: $id, date: $date, energy: $energy, location: $location}';
  }
}
