import 'package:babyapp/domain/diary.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';

class DiaryListModel extends ChangeNotifier {
  List<Diary>? diaries;

  void fetchDiaryList() async {
    const databaseName = 'your_database.db';
    final databasePath = await getDatabasesPath();

    // SQL command literal
    const String createDiarySql =
        'CREATE TABLE Diary(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, day TEXT, color TEXT)';
    const String createToDoSql =
        'CREATE TABLE ToDo (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, start TEXT, end TEXT, notification TEXT, belongings TEXT, color TEXT)';
    WidgetsFlutterBinding.ensureInitialized();
    // Open or connect database
    final database = openDatabase(
      join(databasePath, databaseName),
      onCreate: (db, version) async {
        await db.execute(createDiarySql);
        await db.execute(createToDoSql);
      },
      version: 1,
    );

    final db = await database;
    const String insertSql = 'SELECT * FROM Diary';
    final List<Map<String, dynamic>> maps = await db.rawQuery(insertSql);
    final List<Diary> diaries = List.generate(maps.length, (i) {
      final String? title = maps[i]['title'];
      final String? content = maps[i]['content'];
      final DateTime? day = maps[i]['day'] != null
          ? DateTime.parse(maps[i]['day']).toLocal()
          : null;
      final String? color = maps[i]['color'];
      final int id = maps[i]['id'];
      return Diary(
          id, title, content, day, color);
    }).toList();

    this.diaries = diaries;
    notifyListeners();
  }

  Future delete(Diary diary) async {
    const databaseName = 'your_database.db';
    final databasePath = await getDatabasesPath();
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
      join(databasePath, databaseName),
    );
    final db = await database;
    await db.delete(
      'Diary',
      where: 'id = ?',
      whereArgs: [diary.id],
    );
  }
}

class ChangeCalender with ChangeNotifier {
  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime FocusedDay = DateTime.now();
  DateTime? SelectedDay;

  void changeFormat(format) {
    if (calendarFormat != format) {
      calendarFormat = format;
    }
    notifyListeners();
  }

  void changeSelected(selectedDay, focusedDay) {
    if (!isSameDay(SelectedDay, selectedDay)) {
      SelectedDay = selectedDay;
      FocusedDay = focusedDay;
    }
    notifyListeners();
  }
}
