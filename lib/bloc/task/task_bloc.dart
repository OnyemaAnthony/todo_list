import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_list/models/todo_list_model.dart';
import 'package:todo_list/repository/database_repository.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  DatabaseRepository repository;

  TaskBloc({this.repository}) : super(TaskInitial());

  @override
  Stream<TaskState> mapEventToState(
    TaskEvent event,
  ) async* {
    if (event is FetchAllTaskEvent) {
      yield* _mapFetchAllTAskEventToState(event);
    } else if (event is SaveTaskEvent) {
      _mapSaveTaskEventToState(event);
    }
  }

  Stream<TaskState> _mapFetchAllTAskEventToState(
      FetchAllTaskEvent event) async* {
    yield TaskLoadingState();
    TodoListModel task;

    try {
      List tasks = await repository.geAllTask();
      for (int i = 0; i < tasks.length; i++) {
        task = TodoListModel.map(tasks[i]);
      }
      yield TaskLoadedState(task);
    } catch (e) {
      yield TaskErrorState(e.toString());
    }
  }

  Stream<TaskState> _mapSaveTaskEventToState(SaveTaskEvent event) async* {
    yield TaskLoadingState();

    try {
      await repository.saveTask(event.task);
    } catch (e) {
      yield TaskErrorState(e.toString());
    }
  }
}
