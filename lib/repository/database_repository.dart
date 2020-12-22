import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_list/models/todo_list_model.dart';
import 'package:todo_list/utility/utilities.dart';

class DatabaseRepository {

  static final DatabaseRepository _instance = DatabaseRepository.internal();

  factory DatabaseRepository()=> _instance;


  static Database _db;

  DatabaseRepository.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
  }

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentDirectory.path, 'tododb.db');

    var dataBase = await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE ${Utility.todoTable}(${Utility
            .id} INTEGER PRIMARY KEY, ${Utility.task} TEXT,${Utility
            .deadline }TEXT})");

  }

  Future<int> saveTodo(TodoListModel todoListModel){

  }

}