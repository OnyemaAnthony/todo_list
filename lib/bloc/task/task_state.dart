part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoadingState extends TaskState {}

class TaskLoadedState extends TaskState {
  final List<TodoListModel> task;

  TaskLoadedState(this.task);
  @override
  List<Object> get props => [task];
}
class TaskDeletedState extends TaskState{

}
class CountLoadedState extends TaskState{
  final int count;

  CountLoadedState(this.count);
}

class TaskAddedState extends TaskState {
  final int result;

  TaskAddedState(this.result);
  @override
  List<Object> get props => [result];
}

class TaskErrorState extends TaskState {
  final String message;

  TaskErrorState(this.message);
  @override
  List<Object> get props => [message];
}
