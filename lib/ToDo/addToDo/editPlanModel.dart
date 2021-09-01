import 'package:babyapp/domain/toDo.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class EditPlanModel extends ChangeNotifier {
  final ToDo plan;

  EditPlanModel(this.plan) {
    titleController.text = plan.title!;
    contentController.text = plan.content!;
    startController.text = plan.start.toString();
    endController.text = plan.end.toString();
    notificationController.text = plan.notification.toString();
    belongingsController.text = plan.belongings.toString();
    colorController.text = plan.color!;
  }

  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final contentController = TextEditingController();
  final startController = TextEditingController();
  final endController = TextEditingController();
  final notificationController = TextEditingController();
  final belongingsController = TextEditingController();
  final colorController = TextEditingController();

  String? title;
  String? content;
  DateTime? start;
  DateTime? end;
  DateTime? notification;
  String? belongings;
  String? color;


  void setTitle(String title) {
    this.title = title;
    notifyListeners();
  }

  void setStart(DateTime start) {
    final year = start.year.toString();
    final month = start.month.toString();
    final day = start.day.toString();
    final hour = start.hour.toString();
    final minute = start.minute.toString();
    this.startController.text = '$year/$month/$day/$hour/$minute';
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

  void setNotification(DateTime notification) {
    final year = notification.year.toString();
    final month = notification.month.toString();
    final day = notification.day.toString();
    final hour = notification.hour.toString();
    final minute = notification.minute.toString();
    this.notificationController.text = '$year/$month/$day/$hour/$minute';
    notifyListeners();
  }

  void setBelongings(String belongings) {
    this.belongings = belongings;
    notifyListeners();
  }

  void setColor(String? color) {
    this.color = color;
    notifyListeners();
  }

  bool isWritten(){
    return start != null;
  }

  bool isUpdated(){
    return title != null || content != null || start != null || end != null || notification != null || belongings != null || color != null;
  }

  Future update() async {
    this.title = titleController.text;
    this.content = contentController.text;
    this.belongings = belongingsController.text;
    this.color = colorController.text;
    final databaseName = 'your_database.db';
    final databasePath = await getDatabasesPath();
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
      join(databasePath, databaseName),
    );
    final String tableName = 'ToDo';
    Map<String, dynamic> record = {
      'title': title,
      'content': content,
      'start': start,
      'end': end,
      'notification': notification,
      'belongings': belongings,
      'color': color,
    };
    final db = await database;
    await db.update(
      tableName,
      record,
      where: 'id = ?',
      whereArgs: [plan.id],
    );
  }
}