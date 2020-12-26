part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();
}

class TaskInitial extends TaskState {
  @override
  List<Object> get props => [];
}

class TaskLoadingState extends TaskState{
  @override
  List<Object> get props => [];

}

class TaskLoadedState extends TaskState{
  final TodoListModel task;

  TaskLoadedState(this.task);
  @override
  List<Object> get props => [];

}

class TaskErrorState extends TaskState{
  final String message;

  TaskErrorState(this.message);
  @override
  List<Object> get props => [];

}
