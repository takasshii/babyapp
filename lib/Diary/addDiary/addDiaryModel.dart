import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AddDiaryModel extends ChangeNotifier {
  String? title;
  String? content;
  DateTime? day;
  String? color;

  AddDiaryModel() {
    DateTime today = DateTime.now();
    dayController.text = '${today.year.toString()}/${today.month.toString()}/${today.day.toString()}';
    day = DateTime.now();
  }

  final dayController = TextEditingController();

  void setDay(DateTime start) {
    final year = start.year.toString();
    final month = start.month.toString();
    final day = start.day.toString();
    dayController.text = '$year/$month/$day';
    notifyListeners();
  }

  bool isWritten() {
    return day != null;
  }

  Future addPlan() async {
    if (day == null) {
      throw Exception("日付が入力されていません");
    }

    const databaseName = 'your_database.db';
    final databasePath = await getDatabasesPath();
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
      join(databasePath, databaseName),
    );
    final db = await database;
    const String tableName = 'Diary';
    Map<String, dynamic> record = {
      'title': title,
      'content': content,
      'day': day?.toUtc().toIso8601String(),
      'color': color,
    };

    await db.insert(
      tableName,
      record,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
