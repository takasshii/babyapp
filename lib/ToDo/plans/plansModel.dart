import 'package:babyapp/domain/toDo.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

class PlanListModel extends ChangeNotifier {
  List<ToDo>? plans;


  //SqLiteでToDOテーブルとDiaryテーブル作成
  void fetchPlanList() async {
    const databaseName = 'your_database.db';
    final databasePath = await getDatabasesPath();
    // SQL command literal
    const String createDiarySql =
        'CREATE TABLE Diary (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, day TEXT, color TEXT)';
    const String createToDoSql =
        'CREATE TABLE ToDo (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, start TEXT, end TEXT, notification TEXT, belongings TEXT, color TEXT)';
    WidgetsFlutterBinding.ensureInitialized();
    // Open or connect database
    final database = openDatabase(
      join(databasePath, databaseName),
      onCreate: (db, version) async {
        await db.execute(createToDoSql);
        await db.execute(createDiarySql);
      },
      version: 1,
    );



    //SQLiteからToDoデータを取得
    final db = await database;
    const String insertSql = 'SELECT * FROM ToDo';
    final List<Map<String, dynamic>> maps = await db.rawQuery(insertSql);
    final List<ToDo> plans = List.generate(maps.length, (i) {
      final String title = maps[i]['title'];
      final String? content = maps[i]['content'];
      final DateTime? start = maps[i]['start'] != null
          ? DateTime.parse(maps[i]['start']).toLocal()
          : null;
      //DateTimeはSQLiteにないので、String→DateTimeに変更
      final DateTime? end = maps[i]['end'] != null
          ? DateTime.parse(maps[i]['end']).toLocal()
          : null;
      //DateTimeはSQLiteにないので、String→DateTimeに変更
      final DateTime? notification = maps[i]['notification'] != null
          ? DateTime.parse(maps[i]['notification']).toLocal()
          : null;
      final String? belongings = maps[i]['belongings'];
      final String? color = maps[i]['color'];
      final int id = maps[i]['id'];
      return ToDo(
          id, title, content, start, end, notification, belongings, color);
    }).toList();
    //start時間の早い順にソート、指定なしは一番後ろに持ってきた
    plans.sort((a, b) {
      int result;
      if (a.start == null) {
        result = 1;
      } else if (b.start == null) {
        result = -1;
      } else {
        // Ascending Order
        result = a.start!.compareTo(b.start!);
      }
      return result;
    });

    this.plans = plans;
    notifyListeners();
  }


  //SQLiteでDelete
  // id=?とすると、SQLインジェクション対策になる
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
  }@override
  notifyListeners();
}


class ChangeCheck extends ChangeNotifier {
  bool changeCheck = false;
  void changeIcon() {
    changeCheck = true;
    notifyListeners();
  }
}