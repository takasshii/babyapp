import 'package:babyapp/domain/diary.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class EditDiaryModel extends ChangeNotifier {
  final Diary diary;

  String? title;
  String? content;
  DateTime? day;
  String? color;

  EditDiaryModel(this.diary) {
    titleController.text = diary.title ?? '';
    contentController.text = diary.content ?? '';
    if (diary.day != null) {
      dayController.text =
          '${diary.day!.year}/${diary.day!.month}/${diary.day!.day}';
      day = diary.day;
    } else {
      dayController.text = '';
    }
    colorController.text = diary.color ?? "";
  }

  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final dayController = TextEditingController();
  final colorController = TextEditingController();

  void setTitle(String title) {
    this.title = title;
    notifyListeners();
  }

  void setDay(DateTime Day) {
    final year = Day.year.toString();
    final month = Day.month.toString();
    final day = Day.day.toString();
    dayController.text = '$year/$month/$day';
    this.day = Day;
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
    return title != null || content != null || day != null || color != null;
  }

  Future update() async {
    title = titleController.text;
    if (day == null) {
      throw Exception("日付が入力されていません");
    }
    content = contentController.text;
    color = colorController.text;
    const databaseName = 'your_database.db';
    final databasePath = await getDatabasesPath();
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
      join(databasePath, databaseName),
    );
    const String tableName = 'Diary';
    Map<String, dynamic> record = {
      'title': title,
      'content': content,
      'day': day?.toUtc().toIso8601String(),
      'color': color,
    };
    final db = await database;
    await db.update(
      tableName,
      record,
      where: 'id = ?',
      whereArgs: [diary.id],
    );
  }
}
