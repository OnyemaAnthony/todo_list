part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class FetchAllTaskEvent extends TaskEvent {}

class SaveTaskEvent extends TaskEvent {
  final TodoListModel task;

  SaveTaskEvent(this.task);

  @override
  List<Object> get props => [task];

  @override
  String toString() => task.toString();
}
