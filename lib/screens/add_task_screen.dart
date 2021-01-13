import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/bloc/task/task_bloc.dart';
import 'package:todo_list/models/todo_list_model.dart';
import 'package:todo_list/repository/database_repository.dart';
import 'package:todo_list/screens/empty_tas_screen.dart';
import 'package:todo_list/screens/home_screen.dart';
import 'package:todo_list/services/services.dart';
import 'package:todo_list/utility/utilities.dart';

class AddTaskScreen extends StatefulWidget {
  final TodoListModel todo;

  AddTaskScreen([this.todo]);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TaskBloc taskBloc;

  TextEditingController taskController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  final DateFormat formatter = DateFormat('dd, MMMM, yyyy');

  DateTime deadlineDate = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.todo != null) {
      dateController.text = widget.todo.formattedDate;
      taskController.text = widget.todo.task;
      timeController.text = widget.todo.time;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return await DatabaseRepository().getCount() !=  0? Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => HomeScreen())): Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (_) => EmptyTaskScreen()));
      },
      child: BlocProvider(
        create: (_) =>
            TaskBloc(
              repository: DatabaseRepository(),
            ),
        child: Builder(
          builder: (BuildContext ctx) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text('Add a new Task', style: TextStyle(
                    color: Colors.white
                ),),
                actions: [
                  GestureDetector(
                    onTap: () {
                      saveTask(ctx);
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Icon(
                        Icons.check,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              body: buildTask(ctx),
            );
          },
        ),
      ),
    );
  }

  Widget buildTaskForm(BuildContext ctx) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
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
                      validator: (input) =>
                      input.isEmpty ? 'Please Enter a valid task' : null,
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
                  color: Theme
                      .of(context)
                      .primaryColor,
                  size: 28,
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            dateController.text.isNotEmpty
                ? Center(
              child: Text(
                "Dead line",
                style: TextStyle(fontSize: 19),
              ),
            )
                : Text('Dead line'),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: 400,
                    child: TextFormField(
                      validator: (input) =>
                      input.isEmpty ? 'Please Enter a valid date' : null,
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
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.01,
                ),
                Icon(
                  Icons.date_range,
                  color: Theme
                      .of(context)
                      .primaryColor,
                  size: 28,
                ),
                dateController.text.isEmpty
                    ? Container()
                    : Expanded(child: buildTime()),
              ],
            ),
          ],
        ),
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
              validator: (input) => input.isEmpty ? "Enter a valid time" : null,
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
          color: Theme
              .of(context)
              .primaryColor,
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
        time = picked;
        timeController.text = picked.format(context);
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
        deadlineDate = pickedDate;
        dateController.text = formatter.format(pickedDate).toString();
      });
    });
  }

//

  saveTask(BuildContext ctx) async {
    if (_formKey.currentState.validate()) {
      if (widget.todo != null) {
        ctx.read<TaskBloc>().add(UpdateTaskEvent(TodoListModel(
          deadLine: deadlineDate.toString(),
          task: taskController.text,
          time: timeController.text,
          id: widget.todo.id
        )));

        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
      } else {
        ctx.read<TaskBloc>().add(
          SaveTaskEvent(
            TodoListModel(
                deadLine: deadlineDate.toString(),
                task: taskController.text,
                time: timeController.text,
                formattedDate: dateController.text
            ),
          ),
        );
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
      }
    }
  }

  Widget buildTask(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (ctx, state) {
        if (state is TaskInitial) {
          return buildTaskForm(ctx);
        } else if (state is TaskLoadingState) {
          return Utility.showCirclarLoader();
        } else if (state is TaskAddedState) {
          return buildTaskForm(ctx);
        } else if (state is TaskErrorState) {
          return Utility.showErrorMessage(state.message);
        }
        return Container();
      },
    );
  }
}
