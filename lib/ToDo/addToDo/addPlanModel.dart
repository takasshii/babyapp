import 'package:babyapp/domain/toDo.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class AddPlanModel extends ChangeNotifier {
  String? title;
  String? content;
  DateTime? start;
  DateTime? end;
  DateTime? notification;
  String? belongings;
  String? color;

  final startController = TextEditingController();
  final endController = TextEditingController();
  final notificationController = TextEditingController();

  void setStart(DateTime start) {
    final year = start.year.toString();
    final month = start.month.toString();
    final day = start.day.toString();
    final hour = start.hour.toString();
    final minute = start.minute.toString();
    this.startController.text = '$year/$month/$day/$hour/$minute';
    end != null ? this.endController.text = '$year/$month/$day/$hour/${(start.minute+10).toString()}':this.endController.text = '';
    notifyListeners();
  }

  void setEnd(DateTime end) {
    final year = end.year.toString();
    final month = end.month.toString();
    final day = end.day.toString();
    final hour = end.hour.toString();
    final minute = end.minute.toString();
    this.endController.text = '$year/$month/$day/$hour/$minute';
    notifyListeners();
  }

  void setnotification(DateTime end) {
    final year = notification!.year.toString();
    final month = notification!.month.toString();
    final day = notification!.day.toString();
    final hour = notification!.hour.toString();
    final minute = notification!.minute.toString();
    this.endController.text = '$year/$month/$day/$hour/$minute';
    notifyListeners();
  }

  bool isWritten(){
    return start != null;
  }

  Future addPlan() async {
    if (title == null || title!.isEmpty) {
      throw Exception("titleが入力されていません");
    }

    // Create an absolute path to databse
    final database_name = 'your_database.db';
    final database_path = await getDatabasesPath();
    final String path_to_db = path.join(database_path, database_name);

    // SQL command literal
    final String sql =
        'CREATE TABLE ToDo (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, start DATETIME, end DATETIME, notification DATETIME, belongings TEXT, color TEXT)';

    // Open or connect database
    Future<Database> database = openDatabase(path_to_db,
        // Create table
        onCreate: (Database db, int version) async {
      await db.execute(sql);
    });

    final db = await database;
    final String table_name = 'ToDo';
    Map<String, dynamic> record = {
      'title': title,
      'content': content,
      'start': start,
      'end': end,
      'notification': notification,
      'belongings': belongings,
      'color': color,
    };


    await db.insert(
      table_name,
      record,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
