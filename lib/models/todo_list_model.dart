import 'package:equatable/equatable.dart';

class TodoListModel extends Equatable {
  String task;
  String deadLine;
  String time;
  String formattedDate;
  int id;

  TodoListModel(
      {this.id, this.deadLine, this.task, this.time, this.formattedDate});

  TodoListModel.map(dynamic obj) {
    this.task = obj['task'];
    this.deadLine = obj['deadLine'];
    this.id = obj['id'];
    this.time = obj['time'];
    this.formattedDate = obj['formattedDate'];
  }

  Map<String, dynamic> toMap() {
    return {
      'task': task,
      'deadLine': deadLine,
      'id': id,
      'time': time,
      'formattedDate':formattedDate,
    };
  }

  TodoListModel.fromMap(Map<String, dynamic> map) {
    this.task = map['task'];
    this.deadLine = map['deadLine'];
    this.id = map['id'];
    this.time = map['time'];
    this.formattedDate = map['formattedDate'];
  }

  @override
  String toString() => '[id: $id, task: $task, deadLine: $deadLine]';

  @override
  List<Object> get props => [task, deadLine, id];
}
