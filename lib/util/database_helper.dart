import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:suncheck/model/record.dart';

class DatabaseHelper {
  static const String TABLE_NAME = 'records';
  static Database db;

  static Future<void> initDatabase() async {
    db = await openDatabase(
      join(await getDatabasesPath(), 'suncheck_database8.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE records(id INTEGER PRIMARY KEY, date TEXT, energy INTEGER)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insertRecord(Record record) async {
    await db.insert(
      TABLE_NAME,
      record.toMap(),
      conflictAlgorithm: ConflictAlgorithm.rollback,
    );
  }

  static Future<List<Record>> records() async {
    final List<Map<String, dynamic>> maps = await db.query(TABLE_NAME);
    return List.generate(maps.length, (i) {
      return Record(
        id: maps[i]['id'],
        date: DateTime.parse(maps[i]['date']),
        energy: maps[i]['energy'],
      );
    });
  }

  static Future<void> updateRecord(Record record) async {
    await db.update(
      TABLE_NAME,
      record.toMap(),
      where: 'id = ?',
      whereArgs: [record.id],
    );
  }

  static Future<List<Record>> recordsByYearAndMonth(String year, String month) async {
    List<Map> maps = await db.query(TABLE_NAME, where: 'date LIKE ?', whereArgs: ['$year-$month%'], orderBy: 'date');
    return List.generate(maps.length, (i) {
      return Record(
        id: maps[i]['id'],
        date: DateTime.parse(maps[i]['date']),
        energy: maps[i]['energy'],
      );
    });
  }

  static Future<Record> findRecordByDate(DateTime dateTime) async {
    DateTime yearAndMonth = DateTime.parse(DateFormat('yyyy-MM-dd 00:00:00.000').format(dateTime));
    List<Map> maps = await db.query(TABLE_NAME, where: 'date = ?', whereArgs: [yearAndMonth.toString()]);
    if (maps.isEmpty) {
      throw Exception('no record by date');
    } else {
      return Record(
        id: maps.first['id'],
        date: DateTime.parse(maps.first['date']),
        energy: maps.first['energy'],
      );
    }
  }
}
