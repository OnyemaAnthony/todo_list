import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_list/repository/database_repository.dart';
import 'package:todo_list/screens/empty_tas_screen.dart';
import 'package:todo_list/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  var db = await DatabaseRepository().getCount();
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
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: count <= 0 ? EmptyTaskScreen() : HomeScreen(),
    );
  }
}
