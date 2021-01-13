import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/utility/utilities.dart';
import 'dart:io';
import 'package:path/path.dart';

class SqfLiteReference {
  static final SqfLiteReference _instance = SqfLiteReference.internal();

  factory SqfLiteReference() => _instance;
  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return db;
  }

  SqfLiteReference.internal();

  Future<Database> initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentDirectory.path, 'tododb.db');

    var dataBase = await openDatabase(path, version: 1, onCreate: _onCreate);
    return dataBase;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
      "CREATE TABLE ${Utility.todoTable}(${Utility.id} INTEGER PRIMARY KEY, ${Utility.task} TEXT,${Utility.deadline} TEXT,${Utility.deadLineTime} TEXT, ${Utility.formattedDate} TEXT )",
    );
  }
}
