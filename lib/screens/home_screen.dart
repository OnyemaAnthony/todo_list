import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/task/task_bloc.dart';
import 'package:todo_list/repository/database_repository.dart';
import 'package:todo_list/utility/utilities.dart';
import 'package:todo_list/widget/task_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TaskBloc taskBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          TaskBloc(repository: DatabaseRepository()),
      child: Builder(
        builder: (BuildContext context) {
          taskBloc = BlocProvider.of<TaskBloc>(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('Todo List'),
              centerTitle: true,
            ),
            body: BlocBuilder<TaskBloc,TaskState>(
              builder: (context, state) {
                if (state is TaskLoadingState) {
                  return Utility.showCirclarLoader();
                } else if (state is TaskLoadedState) {
                  return TaskList(state.task);
                }
                return Container();
              },
            ),
          );
        },
      ),
    );
  }
}
