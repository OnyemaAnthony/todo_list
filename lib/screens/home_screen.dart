import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/task/task_bloc.dart';
import 'package:todo_list/models/todo_list_model.dart';
import 'package:todo_list/repository/database_repository.dart';
import 'package:todo_list/screens/add_task_screen.dart';
import 'package:todo_list/utility/utilities.dart';
import 'package:todo_list/widget/task_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<TodoListModel> todoList = <TodoListModel>[];
  TaskBloc taskBloc;

  @override
  void initState() {
    super.initState();
    readTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder:(_)=>AddTaskScreen()));

        },
        child: Icon(Icons.add),
      ),
      body: Container(
        child: Column(
          children: [
//            Center(
//              child: Text(todoList[0].task),
//            ),

          ],
        ),
      ),
    );
  }

  readTask() async {
    List taskList = await DatabaseRepository().geAllTask();
    taskList.forEach((task) {
      setState(() {
        todoList.add(TodoListModel.map(task));
      });
    });
  }
}
