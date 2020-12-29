import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/simple_bloc_observer.dart';
import 'package:todo_list/bloc/task/task_bloc.dart';
import 'package:todo_list/models/todo_list_model.dart';
import 'package:todo_list/repository/database_repository.dart';
import 'package:todo_list/screens/empty_tas_screen.dart';
import 'package:todo_list/screens/home_screen.dart';
import 'package:todo_list/utility/utilities.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);


  runApp(BlocProvider(
      create: (BuildContext context)=>TaskBloc(repository: DatabaseRepository())..add(GetCountEvent()),
      child: MyApp()));
}


class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
     home: BlocBuilder<TaskBloc,TaskState>(
       builder: (context,state){
         if(state is TaskLoadingState){
           //return Utility.showCirclarLoader();
         }else if(state is CountLoadedState){
          return state.count <=0 ? EmptyTaskScreen(): HomeScreen();
         }else if(state is TaskErrorState){
           return Utility.showErrorMessage(state.message);
         }
         return Container();

       },
     ),
    );
  }
}
