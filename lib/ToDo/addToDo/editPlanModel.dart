import 'package:babyapp/domain/toDo.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class EditPlanModel extends ChangeNotifier {
  final ToDo plan;
  String? title;
  String? content;
  DateTime? start;
  DateTime? end;
  DateTime? notification;
  String? belongings;
  String? color;

  EditPlanModel(this.plan) {
    titleController.text = plan.title;
    contentController.text = plan.content ?? '';
    if (plan.start != null) {
      startController.text =
          '${plan.start!.month}/${plan.start!.day} ${plan.start!.hour}:${plan.start!.minute}';
      start = plan.start;
    } else {
      startController.text = '';
    }
    if (plan.end != null) {
      endController.text =
          '${plan.end!.month}/${plan.end!.day} ${plan.end!.hour}:${plan.end!.minute}';
      end = plan.end;
    } else {
      endController.text = '';
    }
    if (plan.notification != null) {
      notificationController.text =
          '${plan.notification!.month}/${plan.notification!.day} ${plan.notification!.hour}:${plan.notification!.minute}';
      notification = plan.notification;
    } else {
      notificationController.text = '';
    }
    belongingsController.text = plan.belongings ?? "";
    colorController.text = plan.color ?? "";
  }

  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final contentController = TextEditingController();
  final startController = TextEditingController();
  final endController = TextEditingController();
  final notificationController = TextEditingController();
  final belongingsController = TextEditingController();
  final colorController = TextEditingController();

  void setTitle(String title) {
    this.title = title;
    notifyListeners();
  }

  void setStart(DateTime start) {
    final month = start.month.toString();
    final day = start.day.toString();
    final hour = start.hour.toString();
    final minute = start.minute.toString();
    startController.text = '$month/$day $hour:$minute';
    if (end == null || start.isAfter(end!)) {
      end = start.add(Duration(minutes: 10));
      setEnd(end!);
    }
    notifyListeners();
  }

  void setEnd(DateTime end) {
    final month = end.month.toString();
    final day = end.day.toString();
    final hour = end.hour.toString();
    final minute = end.minute.toString();
    endController.text = '$month/$day $hour:$minute';
    if (start == null || start!.isAfter(end)) {
      start = end.add(Duration(minutes: 10) * -1);
      setStart(start!);
    }
    notifyListeners();
  }

  void setNotification(DateTime notification) {
    final month = notification.month.toString();
    final day = notification.day.toString();
    final hour = notification.hour.toString();
    final minute = notification.minute.toString();
    notificationController.text = '$month/$day $hour:$minute';
    notifyListeners();
  }

  void setBelongings(String belongings) {
    this.belongings = belongings;
    notifyListeners();
  }

  void setContent(String content) {
    this.content = content;
    notifyListeners();
  }

  void setColor(String? color) {
    this.color = color;
    notifyListeners();
  }

  bool isUpdated() {
    return title != null ||
        content != null ||
        start != null ||
        end != null ||
        notification != null ||
        belongings != null ||
        color != null;
  }

  Future update() async {
    title = titleController.text;
    if (title == null || title!.isEmpty) {
      throw Exception("titleが入力されていません");
    }
    content = contentController.text;
    belongings = belongingsController.text;
    color = colorController.text;
    const databaseName = 'your_database.db';
    final databasePath = await getDatabasesPath();
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
      join(databasePath, databaseName),
    );
    const String tableName = 'ToDo';
    Map<String, dynamic> record = {
      'title': title,
      'content': content,
      'start': start?.toUtc().toIso8601String(),
      'end': end?.toUtc().toIso8601String(),
      'notification': notification?.toUtc().toIso8601String(),
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
