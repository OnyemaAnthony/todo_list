import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_list/models/todo_list_model.dart';
import 'package:todo_list/repository/database_repository.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  DatabaseRepository _repository;

  TaskBloc({@required DatabaseRepository repository})
      : assert(repository != null),
        _repository = repository,
        super(TaskInitial());

  @override
  String toString() => 'Task Bloc';

  @override
  Stream<TaskState> mapEventToState(
    TaskEvent event,
  ) async* {
    if (event is FetchAllTaskEvent) {
      yield* _mapFetchAllTAskEventToState(event);
    } else if (event is SaveTaskEvent) {
      yield* _mapSaveTaskEventToState(event);
    } else if (event is GetCountEvent) {
      yield* _mapGetCountEventToState(event);
    }else if(event is DeleteTaskEvent){
      yield* _mapDeleteTaskToState(event);
    }else if(event is UpdateTaskEvent){
      yield*_mapUpdateTaskEventToState(event);
    }
  }

  Stream<TaskState> _mapFetchAllTAskEventToState(
    FetchAllTaskEvent event,
  ) async* {
    yield TaskLoadingState();

    try {
      List<TodoListModel> task = await _repository.geAllTask();
      yield TaskLoadedState(task);
    } catch (e) {
      yield TaskErrorState(e.toString());
    }
  }

  Stream<TaskState> _mapSaveTaskEventToState(SaveTaskEvent event) async* {
    yield TaskLoadingState();

    try {
      int result = await _repository.saveTask(event.task);

      yield TaskAddedState(result);
    } catch (e) {
      yield TaskErrorState(e.toString());
    }
  }

  Stream<TaskState> _mapGetCountEventToState(GetCountEvent event) async* {
    yield TaskLoadingState();

    try {
      int count = await _repository.getCount();
      yield CountLoadedState(count);
    } catch (e) {
      yield TaskErrorState(e.toString());
    }
  }

  Stream<TaskState>_mapDeleteTaskToState(DeleteTaskEvent event)async* {
    yield TaskLoadingState();
    try{

      _repository.deleteTask(event.id).asStream().listen((event) {
        add(GetCountEvent());
      });
      yield TaskDeletedState();

    }catch(e){
      yield TaskErrorState(e.toString());
    }

  }

  Stream<TaskState>_mapUpdateTaskEventToState(UpdateTaskEvent event)async* {
    yield TaskLoadingState();

    try{
      await _repository.updateTask(event.todo);

    }catch(e){
      yield TaskErrorState(e.toString());
    }
  }
}
