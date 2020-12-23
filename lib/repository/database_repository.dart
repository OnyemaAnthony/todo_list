import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_list/models/todo_list_model.dart';
import 'package:todo_list/utility/utilities.dart';

class DatabaseRepository {
  static final DatabaseRepository _instance = DatabaseRepository.internal();

  factory DatabaseRepository() => _instance;

  static Database _db;



  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return db;
  }
  DatabaseRepository.internal();
  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();


    String path = join(documentDirectory.path, 'tododb.db');

    var dataBase = await openDatabase(path, version: 1, onCreate: _onCreate);
    return dataBase;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE ${Utility.todoTable}(${Utility.id} INTEGER PRIMARY KEY, ${Utility.task} TEXT,${Utility.deadline} TEXT)");
  }

  Future<int> saveTask(TodoListModel todoListModel) async {
    var dbClient = await db;
    print(dbClient == null);

    if(dbClient != null){
      int result =
      await dbClient.insert(Utility.todoTable, todoListModel.toMap());
      return result;
    }

  }

  Future<List> geAllTask() async {
    var dbClient = await db;

    var result = await dbClient.rawQuery("SELECT * FROM ${Utility.todoTable}");

    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;

    return Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) FROM ${Utility.todoTable}"));
  }

  Future<TodoListModel> getTask(int id) async {
    var dbClient = await db;

    var result = await dbClient.rawQuery(
        "SELECT * FROM ${Utility.todoTable} WHERE ${Utility.id} = $id");

    if (result.length == 0) {
      return null;
    } else {
      return TodoListModel.fromMap(result.first);
    }
  }

  Future<int> deleteTask(int id) async {
    var dbClient = await db;

    return await dbClient
        .delete(Utility.todoTable, where: "${Utility.id} = ?", whereArgs: [id]);
  }

  Future<int> updateTask(TodoListModel todoListModel) async {
    var dbClient = await db;
    return await dbClient.update(Utility.todoTable, todoListModel.toMap(),
        where: "${Utility.id} = ?", whereArgs: [todoListModel.id]);
  }

  Future close()async{
    var dbClient = await db;
    return dbClient.close();
  }
}
