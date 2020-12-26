part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
}

class FetchAllTaskEvent extends TaskEvent{
  @override
  List<Object> get props => [];

}

class SaveTaskEvent extends TaskEvent{
  final TodoListModel task;

  SaveTaskEvent(this.task);

  @override
  List<Object> get props => [];
}
