import 'package:flutter/material.dart';
import 'package:todo_list/models/todo_list_model.dart';

class TaskList extends StatelessWidget {
  final TodoListModel task;
  TaskList(this.task);
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(task.task,style: TextStyle(
      fontSize: 30,
      color: Colors.red
    ),));
  }
}
