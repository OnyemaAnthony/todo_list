import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/task/task_bloc.dart';
import 'package:todo_list/models/todo_list_model.dart';
import 'package:todo_list/repository/database_repository.dart';
import 'package:todo_list/screens/add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<TodoListModel> todoList = <TodoListModel>[];
  TaskBloc taskBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          TaskBloc(repository: DatabaseRepository())..add(FetchAllTaskEvent()),
      child: Builder(
        builder: (BuildContext ctx) {
          return Scaffold(
              appBar: AppBar(
                title: Text('Todo List'),
                centerTitle: true,
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => AddTaskScreen(),
                    ),
                  );
                },
                child: Icon(Icons.add),
              ),
              body: BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  if (state is TaskLoadedState) {
                    return buildTaskList(state.task);
                  }
                  return Container();
                },
              ));
        },
      ),
    );
  }

  Widget buildTaskList(List<TodoListModel> task) {
    return ListView.builder(
        itemCount: task.length,
        itemBuilder: (context, index) {
          TodoListModel todo = task[index];
          return Container(
            padding: const EdgeInsets.all(12.0),
            child: Material(
              elevation: 4.0,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=> AddTaskScreen(todo)));
                },
                child: Container(
                  //height: double.parse(todo.task.length.toString()),

                  child: Row(
                    children: <Widget>[
                      ClipRRect(
                        child: Container(width: 5, color: Colors.red),
                      ),
                      Checkbox(value: false, onChanged: null),
                      Expanded(
                        child: Text(
                          todo.task,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
