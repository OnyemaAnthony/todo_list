import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/simple_bloc_observer.dart';
import 'package:todo_list/models/todo_list_model.dart';
import 'package:todo_list/repository/database_repository.dart';
import 'package:todo_list/screens/empty_tas_screen.dart';
import 'package:todo_list/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  var db = await DatabaseRepository().getCount();
  var d =  DatabaseRepository();
  TodoListModel model = TodoListModel(task: 'hello',deadLine: 'today');
  //d.saveTask(model);
  //d.deleteTask(0);


  print('no $db');
  runApp(MyApp(db));
}

class MyApp extends StatelessWidget {
  final int count;

  MyApp(this.count);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
       // visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: count <= 0 ? EmptyTaskScreen() : HomeScreen(),
    );
  }
}
