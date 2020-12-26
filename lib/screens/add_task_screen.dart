import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/bloc/task/task_bloc.dart';
import 'package:todo_list/models/todo_list_model.dart';
import 'package:todo_list/repository/database_repository.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TaskBloc taskBloc;

  TextEditingController taskController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  final DateFormat formatter = DateFormat('dd, MMMM, yyyy');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          TaskBloc(repository: DatabaseRepository()),
      child: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Add a new Task'),
              actions: [
                GestureDetector(
                  onTap: () {
                    saveTask(context);
                  },
                  child: Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Icon(
                        Icons.check,
                        size: 30,
                      )),
                )
              ],
            ),
            body: Container(
              margin: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("What need to be done?"),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: 400,
                          child: TextFormField(
                            controller: taskController,
                            textInputAction: TextInputAction.newline,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: 'Enter Task Here',
                              //border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.keyboard_voice,
                        color: Theme.of(context).primaryColor,
                        size: 28,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                      child: Text(
                    "Dead line",
                    style: TextStyle(fontSize: 19),
                  )),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: 400,
                          child: TextFormField(
                            onTap: () {
                              _showDatePicker(context);
                            },
                            controller: dateController,
                            textInputAction: TextInputAction.newline,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: 'Enter Date',
                              //border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),

                      Icon(
                        Icons.date_range,
                        color: Theme.of(context).primaryColor,
                        size: 28,
                      ),
                      //  SizedBox(height: 10,),

                      dateController.text.isEmpty
                          ? Container()
                          : Expanded(child: buildTime()),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Row buildTime() {
    return Row(
      children: [
        Expanded(
          child: Container(
            width: 400,
            child: TextFormField(
              onTap: () {
                _selectTime(context);
              },
              controller: timeController,
              textInputAction: TextInputAction.newline,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: 'Enter Time',
                //border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Icon(
          Icons.timer,
          color: Theme.of(context).primaryColor,
          size: 28,
        ),
      ],
    );
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null)
      setState(() {
        timeController.text = picked.toString().substring(10, 15);
      });
  }

  void _showDatePicker(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(3000))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        dateController.text = formatter.format(pickedDate).toString();
      });
    });
  }

  void saveTask(BuildContext context) {
    taskBloc = BlocProvider.of<TaskBloc>(context);
    taskBloc.add(
      SaveTaskEvent(TodoListModel(
          deadLine: dateController.text, task: taskController.text)),
    );
  }
}