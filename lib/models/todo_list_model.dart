
class TodoListModel{
  String task;
  String deadLine;
  int id;

  TodoListModel({this.deadLine,this.task});


  TodoListModel.map(dynamic obj){
    this.task = obj['task'];
    this.deadLine = obj['deadLine'];
    this.id = obj['id'];
  }

  Map<String,dynamic>toMap(){
   return{
     'task':task,
     'deadLine':deadLine,
     'id':id
   };
  }

  TodoListModel.fromMap(Map<String,dynamic> map){

    this.task = map['task'];
    this.deadLine = map['deadLine'];
    this.id = map['id'];
  }
}