import 'package:babyapp/domain/toDo.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';

class BabyWeightModel extends ChangeNotifier {
  List<ToDo>? plans;

  void fetchPlanList() async {
    const databaseName = 'your_database.db';
    final databasePath = await getDatabasesPath();

    // SQL command literal
    const String createSql =
        'CREATE TABLE ToDo (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, start TEXT, end TEXT, notification TEXT, belongings TEXT, color TEXT)';
    WidgetsFlutterBinding.ensureInitialized();
    // Open or connect database
    final database = openDatabase(
      join(databasePath, databaseName),
      onCreate: (db, version) {
        return db.execute(createSql);
      },
      version: 1,
    );

    final db = await database;
    const String insertSql = 'SELECT * FROM ToDo';
    final List<Map<String, dynamic>> maps = await db.rawQuery(insertSql);
    final List<ToDo> plans = List.generate(maps.length, (i) {
      final String title = maps[i]['title'];
      final String? content = maps[i]['content'];
      final DateTime? start = maps[i]['start'] != null
          ? DateTime.parse(maps[i]['start']).toLocal()
          : null;
      final DateTime? end = maps[i]['end'] != null
          ? DateTime.parse(maps[i]['end']).toLocal()
          : null;
      final DateTime? notification = maps[i]['notification'] != null
          ? DateTime.parse(maps[i]['notification']).toLocal()
          : null;
      final String? belongings = maps[i]['belongings'];
      final String? color = maps[i]['color'];
      final int id = maps[i]['id'];
      return ToDo(
          id, title, content, start, end, notification, belongings, color);
    }).toList();

    this.plans = plans;
    notifyListeners();
  }

  Future delete(ToDo plan) async {
    const databaseName = 'your_database.db';
    final databasePath = await getDatabasesPath();
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
      join(databasePath, databaseName),
    );
    final db = await database;
    await db.delete(
      'ToDo',
      where: 'id = ?',
      whereArgs: [plan.id],
    );
  }
}

class ChangeCalender with ChangeNotifier {
  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  void changeFormat(format) {
    if (calendarFormat != format) {
      calendarFormat = format;
    }
    notifyListeners();
  }

  void changeSelected(selectedDay, focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    }
  }
}
