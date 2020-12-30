import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/task/task_bloc.dart';
import 'package:todo_list/models/todo_list_model.dart';
import 'package:todo_list/repository/database_repository.dart';
import 'package:todo_list/screens/add_task_screen.dart';
import 'package:todo_list/screens/empty_tas_screen.dart';
import 'package:todo_list/utility/utilities.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TaskBloc taskBloc;

  List<bool> _isChecks = List();

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
                  Navigator.of(context).pushReplacement(
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
                    for (int i = 0; i < state.task.length; i++) {
                      _isChecks.add(false);
                    }
                    return buildTaskList(state.task);
                  } else if (state is TaskLoadingState) {
                    return Utility.showCirclarLoader();
                  } else if (state is TaskErrorState) {
                    return Utility.showErrorMessage(state.message);
                  }
                  return Container();
                },
              ));
        },
      ),
    );
  }

  Widget buildTaskList(List<TodoListModel> tasks) {
    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          TodoListModel todo = tasks[index];
          print(index);
          return Container(
            padding: const EdgeInsets.all(12.0),
            child: Material(
              elevation: 4.0,
              child: InkWell(
                onLongPress: () {
                  deleteTask(context, todo, index, tasks);
                },
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => AddTaskScreen(todo)));
                },
                child: Container(
                  child: Row(
                    children: <Widget>[
                      ClipRRect(
                        child: Container(width: 5, color: Colors.red),
                      ),
                      Checkbox(
                          value: _isChecks[index],
                          onChanged: (val) async {
                            setState(() {
                              _isChecks[index] = val;
                              print(_isChecks[index]);
                              if (_isChecks[index]) {}
                              DatabaseRepository().deleteTask(todo.id);
                              tasks.remove(todo);
                            });

                            if (await DatabaseRepository().getCount() == 0) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => EmptyTaskScreen()));
                            }
                          }),
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

  void deleteTask(BuildContext context, TodoListModel todo, int index,
      List<TodoListModel> tasks) {
    Widget cancelButton = FlatButton(
      child: Text('Cancel'),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text('Delete'),
      onPressed: () async {
        setState(() {
          DatabaseRepository().deleteTask(todo.id);
          tasks.remove(todo);
        });


        Navigator.pop(context);
        if (await DatabaseRepository().getCount() == 0) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => EmptyTaskScreen()));
        }
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text('Notice'),
      content: Text('Are you sure you want to delete the selected item ?'),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
