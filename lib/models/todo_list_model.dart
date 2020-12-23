
class TodoListModel{
  String task;
  String deadLine;
  int id;

  TodoListModel({this.id,this.deadLine,this.task});


  TodoListModel.map(dynamic obj){
    this.task = obj['task'];
    this.deadLine = obj['deadLine'];
    this.id = obj['id'];
  }

  Map<String,dynamic>toMap(){
    var map = Map<String,dynamic>();
    map['task'] = task;
    map['deadLine']= deadLine;

    if(id != null){
      map['id'] = id;
    }

    return map;
  }

  TodoListModel.fromMap(Map<String,dynamic> map){

    this.task = map['task'];
    this.deadLine = map['deadLine'];
    this.id = map['id'];
  }
}