import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
    final month = start.month.toString();
    final day = start.day.toString();
    final hour = start.hour.toString();
    final minute = start.minute.toString();
    this.startController.text = '$month/$day $hour:$minute';
    end != null ? this.endController.text = '$month/$day $hour:${(start.minute+10).toString()}':this.endController.text = '';
    notifyListeners();
  }

  void setEnd(DateTime end) {
    final month = end.month.toString();
    final day = end.day.toString();
    final hour = end.hour.toString();
    final minute = end.minute.toString();
    this.endController.text = '$month/$day $hour:$minute';
    notifyListeners();
  }

  void setNotification(DateTime notification) {
    final month = notification.month.toString();
    final day = notification.day.toString();
    final hour = notification.hour.toString();
    final minute = notification.minute.toString();
    this.notificationController.text = '$month/$day $hour:$minute';
    notifyListeners();
  }

  bool isWritten(){
    return start != null;
  }

  Future addPlan() async {
    if (title == null || title!.isEmpty) {
      throw Exception("titleが入力されていません");
    }

    final databaseName = 'your_database.db';
    final databasePath = await getDatabasesPath();
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
      join(databasePath, databaseName),
    );
    final db = await database;
    final String tableName = 'ToDo';
    Map<String, dynamic> record = {
      'title': title,
      'content': content,
      'start': start?.toUtc().toIso8601String(),
      'end': end?.toUtc().toIso8601String(),
      'notification': notification?.toUtc().toIso8601String(),
      'belongings': belongings,
      'color': color,
    };


    await db.insert(
      tableName,
      record,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
