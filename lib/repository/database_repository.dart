import 'package:sqflite/sqflite.dart';
import 'package:todo_list/models/todo_list_model.dart';
import 'package:todo_list/sqflite_reference/sqflite_reference.dart';
import 'package:todo_list/utility/utilities.dart';

class DatabaseRepository {
  Future<int> saveTask(TodoListModel todoListModel) async {
    var dbClient = await SqfLiteReference().db;
    int result =
        await dbClient.insert(Utility.todoTable, todoListModel.toMap());
    return result;
  }

  Future<List<TodoListModel>> geAllTask() async {
    var dbClient = await SqfLiteReference().db;

    var result = await dbClient.rawQuery(
      "SELECT * FROM ${Utility.todoTable}",

    );
    return result.toList().map((todo) => TodoListModel.fromMap(todo)).toList();
  }

  Future<int> getCount() async {
    var dbClient = await SqfLiteReference().db;

    return Sqflite.firstIntValue(
        await dbClient.rawQuery("SELECT COUNT(*) FROM ${Utility.todoTable}"));
  }

  Future<TodoListModel> getTask(int id) async {
    var dbClient = await SqfLiteReference().db;

    var result = await dbClient.rawQuery(
        "SELECT * FROM ${Utility.todoTable} WHERE ${Utility.id} = $id");

    if (result.length == 0) {
      return null;
    } else {
      return TodoListModel.fromMap(result.first);
    }
  }

  Future<int> deleteTask(int id) async {
    var dbClient = await SqfLiteReference().db;

    return await dbClient
        .delete(Utility.todoTable, where: "${Utility.id} = ?", whereArgs: [id]);
  }

  Future<int> updateTask(TodoListModel todoListModel) async {
    var dbClient = await SqfLiteReference().db;
    return await dbClient.update(Utility.todoTable, todoListModel.toMap(),
        where: "${Utility.id} = ?", whereArgs: [todoListModel.id]);
  }

  Future close() async {
    var dbClient = await SqfLiteReference().db;
    return dbClient.close();
  }
}
