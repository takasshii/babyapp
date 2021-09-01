import 'package:babyapp/domain/toDo.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

class PlanListModel extends ChangeNotifier {
  List<ToDo>? plans;

  void fetchPlanList() async {
    final database_name = 'your_database.db';
    final database_path = await getDatabasesPath();
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
      join(database_path, database_name),
    );
    final db = await database;
    final String sql = 'SELECT * FROM ToDo';
    final List<Map<String, dynamic>> maps = await db.rawQuery(sql);
    final List<ToDo> plans = List.generate(maps.length, (i) {
        final String title = maps[i]['title'];
        final String content = maps[i]['content'];
        final DateTime start = maps[i]['start'];
        final DateTime end = maps[i]['end'];
        final DateTime notification = maps[i]['notification'];
        final String belongings = maps[i]['belongings'];
        final String color = maps[i]['color'];
        final int id = maps[i]['id'];
      return ToDo(id, title, content, start, end, notification, belongings, color);
    }).toList();

    this.plans = plans;
    notifyListeners();
  }

  Future delete(ToDo plan) async {
    final database_name = 'your_database.db';
    final database_path = await getDatabasesPath();
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
      join(database_path, database_name),
    );
    final db = await database;
    await db.delete(
      'ToDo',
      where: 'id = ?',
      whereArgs: [plan.id],
    );
  }
}